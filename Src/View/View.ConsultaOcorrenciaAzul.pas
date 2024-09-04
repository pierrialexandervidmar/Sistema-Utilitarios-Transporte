unit View.ConsultaOcorrenciaAzul;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, System.JSON, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls;

type
  TConsultaOcorrenciaAzul = class(TForm)
    Label1: TLabel;
    EditToken: TEdit;
    Label2: TLabel;
    EditChaveNf: TEdit;
    BtnConsultar: TButton;
    BtnLimpar: TButton;
    DadosOcorrenciaAzul: TMemo;
    Label3: TLabel;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Image1: TImage;
    procedure BtnLimparClick(Sender: TObject);
    procedure BtnConsultarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConsultaOcorrenciaAzul: TConsultaOcorrenciaAzul;

implementation

{$R *.dfm}

procedure TConsultaOcorrenciaAzul.BtnConsultarClick(Sender: TObject);
var
  BaseURL, TokenFormatado, ChaveNfeFormatado: string;
  JSONResponse: TJSONObject;
begin
  DadosOcorrenciaAzul.Clear;

  // Formatamos a string
  TokenFormatado := trim(StringReplace(EditToken.Text, '.', '', [rfReplaceAll]));
  TokenFormatado := StringReplace(TokenFormatado, '-', '', [rfReplaceAll]);
  TokenFormatado := StringReplace(TokenFormatado, '/', '', [rfReplaceAll]);
  TokenFormatado := StringReplace(TokenFormatado, ' ', '', [rfReplaceAll]);

  // Formatamos a string da NFE
  ChaveNfeFormatado := trim(StringReplace(EditChaveNf.Text, '.', '', [rfReplaceAll]));
  ChaveNfeFormatado := StringReplace(ChaveNfeFormatado, '-', '', [rfReplaceAll]);
  ChaveNfeFormatado := StringReplace(ChaveNfeFormatado, '/', '', [rfReplaceAll]);
  ChaveNfeFormatado := StringReplace(ChaveNfeFormatado, ' ', '', [rfReplaceAll]);

  BaseURL := 'https://ediapi.onlineapp.com.br/api/Ocorrencias/Consultar?Token=' + TokenFormatado + '&chaveNFE=' + ChaveNfeFormatado;

  RESTClient1.BaseURL := BaseURL;
  RESTRequest1.Method := TRESTRequestMethod.rmGET; // Define o método como GET
  RESTRequest1.Client := RESTClient1;
  RESTRequest1.Response := RESTResponse1;

  try
    RESTRequest1.Execute;

    if RESTResponse1.StatusCode = 200 then
    begin
      try
        JSONResponse := TJSONObject.ParseJSONValue(RESTResponse1.Content) as TJSONObject;
        if JSONResponse <> nil then
        begin
          try
            DadosOcorrenciaAzul.Lines.Text := JSONResponse.Format(2);
          finally
            JSONResponse.Free;
          end;
        end;
      except
        on E: Exception do
          ShowMessage('Erro ao formatar JSON: ' + E.Message);
      end;
    end;

    except
      on E: ERESTException do
      begin
        DadosOcorrenciaAzul.Lines.Add('Erro na requisição REST: ' + E.Message);
      end;
      on E: Exception do
      begin
        DadosOcorrenciaAzul.Lines.Add('Erro inesperado: ' + E.Message);
      end;
    end;
end;

procedure TConsultaOcorrenciaAzul.BtnLimparClick(Sender: TObject);
begin
  EditToken.Clear;
  EditChaveNf.Clear;
  DadosOcorrenciaAzul.Clear;
  EditToken.SetFocus;
end;

procedure TConsultaOcorrenciaAzul.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

end.
