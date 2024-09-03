unit View.ConsultasServicosFlixLog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.JSON, TypInfo;

type
  TConsultasServicosFlixLog = class(TForm)
    EditToken: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    EditCepOrigem: TEdit;
    BtnConsultar: TButton;
    BtnLimpar: TButton;
    Label3: TLabel;
    DadosRespostaFlixlog: TMemo;
    Image1: TImage;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnConsultarClick(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConsultasServicosFlixLog: TConsultasServicosFlixLog;

implementation

{$R *.dfm}

procedure TConsultasServicosFlixLog.BtnConsultarClick(Sender: TObject);
var
  TokenFormatado, CEPOrigemFormatado, HeaderInfo: string;
  I: Integer;
  JSONBody: TJSONObject;
  JSONParcels: TJSONArray;
  JSONParcel: TJSONObject;
  BodyStream: TStringStream;
  ResponseText: string;
  JSONResponse: TJSONValue;
begin
  // Lê o Token e o Cep de origem a partir dos Edit components e formata
  TokenFormatado := Trim(StringReplace(EditToken.Text, ' ', '', [rfReplaceAll]));

  CEPOrigemFormatado := StringReplace(EditCepOrigem.Text, '.', '', [rfReplaceAll]);
  CEPOrigemFormatado := StringReplace(CEPOrigemFormatado, '-', '', [rfReplaceAll]);
  CEPOrigemFormatado := StringReplace(CEPOrigemFormatado, '/', '', [rfReplaceAll]);
  CEPOrigemFormatado := StringReplace(CEPOrigemFormatado, ' ', '', [rfReplaceAll]);

  // Configura o RESTClient com a URL base
  RESTClient1.BaseURL := 'https://freight.flixlog.com/quotation';

  // Configura o RESTRequest com o método POST
  RESTRequest1.Method := rmPOST;

  // Limpa quaisquer parâmetros existentes
  RESTRequest1.Params.Clear;

  // Adiciona o cabeçalho de autorização com o token fornecido
  RESTRequest1.Params.AddHeader('Authorization', TokenFormatado);
  RESTRequest1.Params.AddHeader('Content-Type', 'application/json');

  // Cria o JSON para o corpo da requisição
  JSONBody := TJSONObject.Create;
  try
    JSONBody.AddPair('from', CEPOrigemFormatado);
    JSONBody.AddPair('to', '01501010');

    JSONParcels := TJSONArray.Create;
    JSONParcel := TJSONObject.Create;
    try
      JSONParcel.AddPair('width', TJSONNumber.Create(0.10));
      JSONParcel.AddPair('length', TJSONNumber.Create(0.60));
      JSONParcel.AddPair('height', TJSONNumber.Create(0.10));
      JSONParcel.AddPair('weight', TJSONNumber.Create(0.10));
      JSONParcel.AddPair('quantity', TJSONNumber.Create(1));
      JSONParcel.AddPair('cargo_value', TJSONNumber.Create(0.2));
      JSONParcel.AddPair('reference', 'TRAMFE010');

      JSONParcels.AddElement(JSONParcel);
      JSONBody.AddPair('parcels', JSONParcels);
    except
      JSONParcel.Free;
      raise;
    end;

    JSONBody.AddPair('show_all', TJSONBool.Create(True));

    // Converte o JSON para string e configura o corpo da requisição
    BodyStream := TStringStream.Create(JSONBody.ToString, TEncoding.UTF8);
    try
      //RESTRequest1.Body.Clear;
      RESTRequest1.Body.Add(BodyStream.DataString, TRESTContentType.ctAPPLICATION_JSON);

      // Associa a resposta ao componente RESTResponse
      RESTRequest1.Response := RESTResponse1;

      try
        // Executa a requisição
        RESTRequest1.Execute;

        // Exibe a resposta no componente Memo
        ResponseText := RESTResponse1.Content;
//        DadosRespostaFlixlog.Lines.Text := ResponseText;

        // Adiciona a estrutura da resposta JSON ao Memo
        JSONResponse := TJSONObject.ParseJSONValue(ResponseText);
        try
          if JSONResponse is TJSONObject then
          begin
            DadosRespostaFlixlog.Lines.Add((JSONResponse as TJSONObject).Format(2));
          end
          else if JSONResponse is TJSONArray then
          begin
            DadosRespostaFlixlog.Lines.Add((JSONResponse as TJSONArray).Format(2));
          end
          else
          begin
            DadosRespostaFlixlog.Lines.Add('Resposta não é um JSON válido.');
          end;
        finally
          JSONResponse.Free;
        end;

        DadosRespostaFlixlog.Lines.Add('');
        DadosRespostaFlixlog.Lines.Add('');
        DadosRespostaFlixlog.Lines.Add('');
        DadosRespostaFlixlog.Lines.Add('');
        DadosRespostaFlixlog.Lines.Add('ABAIXO SEGUE PAYLOAD DA REQUISIÇÃO ENVIADA, PARA CONFERÊNCIA: ');

        // Adiciona o método e a URL da requisição ao Memo
        DadosRespostaFlixlog.Lines.Add('Método: ' + GetEnumName(TypeInfo(TRESTRequestMethod), Integer(RESTRequest1.Method)));
        DadosRespostaFlixlog.Lines.Add('URL: ' + RESTClient1.BaseURL + RESTRequest1.Resource);

        // Adiciona os cabeçalhos da requisição ao Memo
        DadosRespostaFlixlog.Lines.Add('=== Headers ===');
        for I := 0 to RESTRequest1.Params.Count - 1 do
        begin
          if RESTRequest1.Params[I].Kind = pkHTTPHEADER then
          begin
            HeaderInfo := RESTRequest1.Params[I].Name + ': ' + RESTRequest1.Params[I].Value;
            DadosRespostaFlixlog.Lines.Add(HeaderInfo);
          end;
        end;

        // Adiciona o corpo da requisição ao Memo
        DadosRespostaFlixlog.Lines.Add('=== Corpo da Requisição ===');
        DadosRespostaFlixlog.Lines.Add(BodyStream.DataString);

      except
        on E: ERESTException do
        begin
          ShowMessage('Erro na requisição: ' + E.Message);
        end;
      end;

    finally
      BodyStream.Free;
    end;

  finally
    JSONBody.Free;
  end;
end;



procedure TConsultasServicosFlixLog.BtnLimparClick(Sender: TObject);
begin
  EditToken.Clear;
  EditCepOrigem.Clear;
  DadosRespostaFlixlog.Clear;
  EditToken.SetFocus;
end;

procedure TConsultasServicosFlixLog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

end.

