unit View.ConsultaOcorrenciaDaytona;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, System.JSON;

type
  TConsultaOcorrenciaDaytona = class(TForm)
    Label4: TLabel;
    Label3: TLabel;
    EditCNPJ: TEdit;
    EditNumeroNf: TEdit;
    Button1: TButton;
    Button2: TButton;
    DadosDaytona: TMemo;
    Label1: TLabel;
    Image1: TImage;
    NetHTTPClient1: TNetHTTPClient;
    NetHTTPRequest1: TNetHTTPRequest;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConsultaOcorrenciaDaytona: TConsultaOcorrenciaDaytona;

implementation

{$R *.dfm}

procedure TConsultaOcorrenciaDaytona.Button1Click(Sender: TObject);
var
  HttpClient: TNetHTTPClient;
  Response: IHTTPResponse;
  URL, HeaderInfo, CNPJFormatado: string;
  JSONArray: TJSONArray;
begin
  HttpClient := TNetHTTPClient.Create(nil);
  try
    // Configura o HttpClient
    HttpClient.AcceptEncoding := 'gzip, deflate';

    CNPJFormatado := trim(StringReplace(EditCNPJ.Text, '.', '', [rfReplaceAll]));
    CNPJFormatado := StringReplace(CNPJFormatado, '-', '', [rfReplaceAll]);
    CNPJFormatado := StringReplace(CNPJFormatado, '/', '', [rfReplaceAll]);
    CNPJFormatado := StringReplace(CNPJFormatado, ' ', '', [rfReplaceAll]);

    // Monta a URL
    URL := 'https://scmdex.azurewebsites.net/api/OcorrenciaCNPJ/181259/' +
           Trim(CNPJFormatado) + '/' +
           Trim(EditNumeroNF.Text) + '/true';

    try
      // Envia a requisição GET
      Response := HttpClient.Get(URL);

      try
        // Tenta parsear e formatar a resposta como um array JSON
        JSONArray := TJSONObject.ParseJSONValue(Response.ContentAsString()) as TJSONArray;
        if Assigned(JSONArray) then
        begin
          DadosDaytona.Lines.Text := JSONArray.Format(2); // Formata com indentação de 2 espaços
        end
        else
        begin
          DadosDaytona.Lines.Text := 'Resposta não é um JSON válido. Conteúdo bruto: ' + sLineBreak + Response.ContentAsString();
        end;
      except
        on E: Exception do
        begin
          DadosDaytona.Lines.Text := 'Erro ao processar a resposta: ' + E.Message + sLineBreak + 'Conteúdo bruto: ' + sLineBreak + Response.ContentAsString();
        end;
      end;

      // Adiciona as informações da requisição ao Memo para conferência
      DadosDaytona.Lines.Add('');
      DadosDaytona.Lines.Add('=== PAYLOAD DA REQUISIÇÃO ENVIADA PARA CONFERÊNCIA ===');
      DadosDaytona.Lines.Add('Método: GET');
      DadosDaytona.Lines.Add('URL: ' + URL);

    except
      on E: Exception do
      begin
        DadosDaytona.Lines.Text := 'Erro na requisição: ' + E.Message;

        // Adiciona informações da tentativa de requisição para conferência
        DadosDaytona.Lines.Add('');
        DadosDaytona.Lines.Add('=== PAYLOAD DA REQUISIÇÃO ENVIADA PARA CONFERÊNCIA ===');
        DadosDaytona.Lines.Add('Método: GET');
        DadosDaytona.Lines.Add('URL: ' + URL);
      end;
    end;

  finally
    HttpClient.Free;
  end;
end;


procedure TConsultaOcorrenciaDaytona.Button2Click(Sender: TObject);
begin
  EditCNPJ.Clear;
  EditNumeroNf.Clear;
  DadosDaytona.Clear;
  EditCNPJ.SetFocus;
end;

procedure TConsultaOcorrenciaDaytona.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

end.

