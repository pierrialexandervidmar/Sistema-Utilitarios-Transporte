unit View.TesteSSW;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, // Inclua a unit para TRichEdit
  Soap.SOAPHTTPClient, Soap.InvokeRegistry, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, Soap.Rio, Soap.SOAPHTTPTrans;

type
  TTesteSSW = class(TForm)
    Label2: TLabel;
    EditDominio: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    EditLogin: TEdit;
    EditSenha: TEdit;
    EditCNPJPagador: TEdit;
    EditCepOrigem: TEdit;
    EditCepDestino: TEdit;
    EditValorNf: TEdit;
    EditQuantidade: TEdit;
    EditPeso: TEdit;
    EditVolume: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    EditCodigoMercadoria: TEdit;
    BtnConsultar: TButton;
    BtnLimpar: TButton;
    Label12: TLabel;
    HTTPRIO1: THTTPRIO;
    RichEdit1: TRichEdit; // Componente TRichEdit
    procedure BtnConsultarClick(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    function DecodeXML(const AText: string): string;
    function ConvertToPointDecimal(const AText: string): string;
    function CleanText(const AText: string): string;
    function CleanCEP(const AText: string): string;
    function CleanCNPJ(const AText: string): string;
    function FormatXML(const AText: string): string; // Nova função para formatar o XML
  public
    { Public declarations }
  end;

var
  Form1: TTesteSSW;

implementation

{$R *.dfm}

function TTesteSSW.DecodeXML(const AText: string): string;
begin
  // Decodifica entidades XML para caracteres normais
  Result := StringReplace(AText, '&lt;', '<', [rfReplaceAll]);
  Result := StringReplace(Result, '&gt;', '>', [rfReplaceAll]);
  Result := StringReplace(Result, '&amp;', '&', [rfReplaceAll]);
  Result := StringReplace(Result, '&quot;', '"', [rfReplaceAll]);
end;

function TTesteSSW.ConvertToPointDecimal(const AText: string): string;
begin
  // Substitui vírgulas por pontos
  Result := StringReplace(AText, ',', '.', [rfReplaceAll]);
end;

function TTesteSSW.CleanText(const AText: string): string;
begin
  // Remove espaços do início e fim do texto e substitui vírgulas por pontos
  Result := ConvertToPointDecimal(Trim(AText));
end;

procedure TTesteSSW.BtnLimparClick(Sender: TObject);
begin
  // Limpa todos os campos Edit
  EditDominio.Text := '';
  EditLogin.Text := '';
  EditSenha.Text := '';
  EditCNPJPagador.Text := '';
  EditCepOrigem.Text := '';
  EditCepDestino.Text := '';
  EditValorNf.Text := '';
  EditQuantidade.Text := '';
  EditPeso.Text := '';
  EditVolume.Text := '';
  EditCodigoMercadoria.Text := '';

  // Limpa o conteúdo do RichEdit
  RichEdit1.Clear;

  // Define o foco no EditDominio
  EditDominio.SetFocus;
end;

function TTesteSSW.CleanCEP(const AText: string): string;
begin
  // Remove pontos, traços, barras e espaços do texto
  Result := StringReplace(AText, '.', '', [rfReplaceAll]);
  Result := StringReplace(Result, '-', '', [rfReplaceAll]);
  Result := StringReplace(Result, '/', '', [rfReplaceAll]);
  Result := StringReplace(Result, ' ', '', [rfReplaceAll]);
end;

function TTesteSSW.CleanCNPJ(const AText: string): string;
begin
  // Remove pontos, traços e espaços do texto, mantendo apenas números
  Result := StringReplace(AText, '.', '', [rfReplaceAll]);
  Result := StringReplace(Result, '-', '', [rfReplaceAll]);
  Result := StringReplace(Result, '/', '', [rfReplaceAll]);
  Result := StringReplace(Result, ' ', '', [rfReplaceAll]);
end;

function TTesteSSW.FormatXML(const AText: string): string;
var
  I: Integer;
  IndentLevel: Integer;
  InsideTag: Boolean;
  InTagName: Boolean;
  TagContent: Boolean;
  LastChar: Char;
begin
  Result := '';
  IndentLevel := 0;
  InsideTag := False;
  InTagName := False;
  TagContent := False;
  LastChar := #0;

  for I := 1 to Length(AText) do
  begin
    case AText[I] of
      '<':
        begin
          if InsideTag and TagContent then
          begin
            // Add a line break before starting a new tag
            Result := Result + sLineBreak;
          end;
          if (I > 1) and (AText[I-1] = '>') then
          begin
            // Add a line break before closing tag if it was inside a tag
            Result := Result + sLineBreak;
          end;

          if (I < Length(AText)) and (AText[I+1] = '/') then
          begin
            // Closing tag
            Dec(IndentLevel);
            Result := Result + StringOfChar(' ', IndentLevel * 2) + AText[I];
            InsideTag := True;
            InTagName := False;
            TagContent := False;
          end
          else if (I < Length(AText)) and (AText[I+1] = '?') then
          begin
            // Processing instruction
            Result := Result + StringOfChar(' ', IndentLevel * 2) + AText[I];
            InsideTag := True;
            InTagName := False;
            TagContent := False;
          end
          else
          begin
            // Opening tag
            Result := Result + StringOfChar(' ', IndentLevel * 2) + AText[I];
            Inc(IndentLevel);
            InsideTag := True;
            InTagName := True;
            TagContent := False;
          end;
          LastChar := AText[I];
        end;

      '>':
        begin
          Result := Result + AText[I];
          if InsideTag then
          begin
            InsideTag := False;
            if not TagContent and not InTagName then
            begin
              // Add line break after tag content if it was inside a tag
              Result := Result;
            end;
            TagContent := True;
          end;
          LastChar := AText[I];
        end;

      #10, #13:
        begin
          // Skip line breaks in the source text
          continue;
        end;

      else
        if (LastChar = '>') and (AText[I] = ' ') then
        begin
          // Avoid extra spaces after tags
          continue;
        end;
        Result := Result + AText[I];
        LastChar := AText[I];
    end;
  end;
end;





procedure TTesteSSW.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

procedure TTesteSSW.BtnConsultarClick(Sender: TObject);
var
  RequestXML, ResponseXML: TStringStream;
  ResponseStr: string;
begin
  // Limpa e converte valores para garantir que utilizem ponto como separador decimal
  EditValorNf.Text := CleanText(EditValorNf.Text);
  EditPeso.Text := CleanText(EditPeso.Text);
  EditVolume.Text := CleanText(EditVolume.Text);

  // Limpa CEPs removendo caracteres não numéricos
  EditCepOrigem.Text := CleanCEP(EditCepOrigem.Text);
  EditCepDestino.Text := CleanCEP(EditCepDestino.Text);

  // Limpa CNPJs removendo caracteres não numéricos
  EditCNPJPagador.Text := CleanCNPJ(EditCNPJPagador.Text);

  // Monta o XML de requisição
  RequestXML := TStringStream.Create(
    '<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
    'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
    'xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" ' +
    'xmlns:urn="urn:sswinfbr.sswCotacao">' +
    '<soapenv:Header/>' +
    '<soapenv:Body>' +
    '<urn:cotar soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">' +
    '<dominio xsi:type="xsd:string">' + EditDominio.Text + '</dominio>' +
    '<login xsi:type="xsd:string">' + EditLogin.Text + '</login>' +
    '<senha xsi:type="xsd:string">' + EditSenha.Text + '</senha>' +
    '<cnpjPagador xsi:type="xsd:string">' + EditCNPJPagador.Text + '</cnpjPagador>' +
    '<cepOrigem xsi:type="xsd:integer">' + EditCepOrigem.Text + '</cepOrigem>' +
    '<cepDestino xsi:type="xsd:integer">' + EditCepDestino.Text + '</cepDestino>' +
    '<valorNF xsi:type="xsd:decimal">' + EditValorNf.Text + '</valorNF>' +
    '<quantidade xsi:type="xsd:integer">' + EditQuantidade.Text + '</quantidade>' +
    '<peso xsi:type="xsd:decimal">' + EditPeso.Text + '</peso>' +
    '<volume xsi:type="xsd:decimal">' + EditVolume.Text + '</volume>' +
    '<mercadoria xsi:type="xsd:integer">' + EditCodigoMercadoria.Text + '</mercadoria>' +
    '<cnpjDestinatario xsi:type="xsd:string">86784208048</cnpjDestinatario>' +
    '<coletar xsi:type="xsd:string">S</coletar>' +
    '<entDificil xsi:type="xsd:string">N</entDificil>' +
    '<destContribuinte xsi:type="xsd:string">N</destContribuinte>' +
    '<qtdePares xsi:type="xsd:integer">1</qtdePares>' +
    '</urn:cotar>' +
    '</soapenv:Body>' +
    '</soapenv:Envelope>'
  );

  ResponseXML := TStringStream.Create;

  try
    // Envia a requisição e recebe a resposta
    HTTPRIO1.HTTPWebNode.URL := 'https://ssw.inf.br/ws/sswCotacao/index.php'; // Defina o URL do serviço SOAP
    HTTPRIO1.HTTPWebNode.Execute(RequestXML, ResponseXML);

    ResponseStr := ResponseXML.DataString;

    // Decodifica o XML, formata e exibe a resposta no TRichEdit
    ResponseStr := DecodeXML(ResponseStr);
    ResponseStr := FormatXML(ResponseStr); // Formata o XML antes de exibir
    RichEdit1.Clear;
    RichEdit1.Lines.Text := ResponseStr;

  except
    on E: Exception do
      ShowMessage('Erro ao enviar requisição: ' + E.Message);
  end;

  // Libera os recursos de memória
  RequestXML.Free;
  ResponseXML.Free;
end;

end.

