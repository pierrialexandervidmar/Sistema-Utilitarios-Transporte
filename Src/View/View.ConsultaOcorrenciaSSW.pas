unit View.ConsultaOcorrenciaSSW;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, System.JSON,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TConsultaOcorrenciaSSW = class(TForm)
    Label1: TLabel;
    EditChaveNF: TEdit;
    BtnConsultar: TButton;
    BtnLimpar: TButton;
    DadosSSW: TMemo;
    Label2: TLabel;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Image1: TImage;
    procedure BtnLimparClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnConsultarClick(Sender: TObject);
  private
    function FormatJson(const JsonString: string): string;
  public
    { Public declarations }
  end;

var
  ConsultaOcorrenciaSSW: TConsultaOcorrenciaSSW;

implementation

{$R *.dfm}
// Fun��o para formatar JSON com indenta��o
function TConsultaOcorrenciaSSW.FormatJson(const JsonString: string): string;
var
  JsonValue: TJSONValue;
begin
  JsonValue := TJSONObject.ParseJSONValue(JsonString);
  try
    if Assigned(JsonValue) then
      Result := JsonValue.Format(2) // Formata com indenta��o de 2 espa�os
    else
      Result := JsonString; // Caso n�o seja um JSON v�lido, retorna o original
  finally
    JsonValue.Free;
  end;
end;

// Procedure respons�vel por executar a busca de ocorr�ncias
procedure TConsultaOcorrenciaSSW.BtnConsultarClick(Sender: TObject);
var
  BaseURL, TokenFormatado, FormattedJSON: string;
  JSONResponse, JSONRequest, JSONBody: TJSONObject;
begin
  BaseURL := 'https://ssw.inf.br/api/trackingdanfe';

  RESTClient1.BaseURL := BaseURL;
  RESTRequest1.Method := TRESTRequestMethod.rmPOST; // Define o m�todo como GET
  RESTRequest1.Client := RESTClient1;
  RESTRequest1.Response := RESTResponse1;
  try
  // Criar o objeto JSON para o corpo da requisi��o
  JSONBody := TJSONObject.Create;
  JSONBody.AddPair('chave_nfe', Trim(EditChaveNF.Text));
  // Definir o corpo da requisi��o com o JSON constru�do
  RESTRequest1.AddBody(JSONBody.ToString, TRESTContentType.ctAPPLICATION_JSON);

  // Executa a requisi��o
  try
    RESTRequest1.Execute;
    DadosSSW.Lines.Text := FormatJson(RESTResponse1.Content); // Exibe a resposta no Memo
      // Verificar a resposta e exibir no Memo
      if RESTResponse1.StatusCode = 200 then
      begin
        try
          // Parse da resposta JSON
          JSONResponse := TJSONObject.ParseJSONValue(RESTResponse1.Content) as TJSONObject;
          JSONRequest := TJSONObject.ParseJSONValue(JSONBody.ToString) as TJSONObject;
          if JSONResponse <> nil then
          begin
            try
              // Formatar o JSON para ser mais leg�vel
              FormattedJSON := JSONResponse.Format(2);  // Usando uma indenta��o de 2 espa�os

              // Exibir JSON formatado no Memo
              DadosSSW.Lines.Text := FormattedJSON;


              // Damos um espamento e adicionamos o Json do Payload da Requisi��o abaixo, para confer�ncia
              DadosSSW.Lines.Add('');
              DadosSSW.Lines.Add('');
              DadosSSW.Lines.Add('');
              DadosSSW.Lines.Add('');
              DadosSSW.Lines.Add('ABAIXO SEGUE PAYLOAD DA REQUISI��O ENVIADA, PARA CONFER�NCIA: ');
              DadosSSW.Lines.Add(JSONRequest.Format(2));

            finally
              JSONResponse.Free;
            end;
          end
          else
          begin
            // Exibir resposta original caso o parse falhe
            DadosSSW.Lines.Text := RESTResponse1.Content;
          end;
        except
          on E: Exception do
            ShowMessage('Erro ao formatar JSON: ' + E.Message);
        end;
      end
      else
      begin
        DadosSSW.Lines.Add('Erro na requisi��o: ' + RESTResponse1.StatusText);
        DadosSSW.Lines.Add('C�digo de status: ' + IntToStr(RESTResponse1.StatusCode));
      end;
    except
      on E: ERESTException do
      begin
        DadosSSW.Lines.Add('Erro na requisi��o REST: ' + E.Message);
      end;
      on E: Exception do
      begin
        DadosSSW.Lines.Add('Erro inesperado: ' + E.Message);
      end;
    end;

  finally
    // Liberar mem�ria do JSON
    JSONBody.Free;
  end;
end;

// Procedure respons�vel por limpar os campos
procedure TConsultaOcorrenciaSSW.BtnLimparClick(Sender: TObject);
begin
  EditChaveNF.Clear;
  DadosSSW.Clear;
  EditChaveNF.SetFocus;
end;

procedure TConsultaOcorrenciaSSW.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

end.
