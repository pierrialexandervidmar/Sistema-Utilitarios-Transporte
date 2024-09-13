unit View.DeParaXmlCte;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.Dialogs, Vcl.Buttons, Xml.XMLDoc, Xml.XMLIntf,
  Xml.xmldom;

type
  TDeParaXmlCte = class(TForm)
    OpenDialog1: TOpenDialog;
    BtnBuscarXML: TButton;
    Label1: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    DadosCotacao: TMemo;
    BtnAnalisar: TBitBtn;
    DadosResumoXML: TMemo;
    DadosResumoCotacao: TMemo;
    Label2: TLabel;
    lbl3: TLabel;
    XMLDocument1: TXMLDocument;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnBuscarXMLClick(Sender: TObject);
    procedure BtnAnalisarClick(Sender: TObject);
  private
    procedure LoadAndAnalyzeXML(const FileName: string);
  public
    { Public declarations }
  end;

var
  DeParaXmlCte: TDeParaXmlCte;

implementation

{$R *.dfm}

procedure TDeParaXmlCte.BtnAnalisarClick(Sender: TObject);
begin
  if OpenDialog1.FileName <> '' then
  begin
    LoadAndAnalyzeXML(OpenDialog1.FileName);
  end
  else
  begin
    ShowMessage('Por favor, selecione um arquivo XML primeiro.');
  end;
end;

procedure TDeParaXmlCte.BtnBuscarXMLClick(Sender: TObject);
var
  XMLFilePath: string;
  Title: string;
  MessageText: string;
begin
  if OpenDialog1.Execute then
  begin
    XMLFilePath := OpenDialog1.FileName;
    Title := 'Busca por XML';
    MessageText := 'Arquivo XML selecionado: ' + XMLFilePath;

    MessageBox(Handle, PChar(MessageText), PChar(Title), MB_OK or MB_ICONINFORMATION);
  end;
end;

procedure TDeParaXmlCte.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

procedure TDeParaXmlCte.LoadAndAnalyzeXML(const FileName: string);
const
  NS = 'http://www.portalfiscal.inf.br/cte'; // Namespace do XML
var
  XMLNode: IXMLNode;
begin
  XMLDocument1.LoadFromFile(FileName);
  XMLDocument1.Active := True;

  // Limpa o memo
  DadosResumoXML.Clear;

  // Navega para o nó infCte
  XMLNode := XMLDocument1.DocumentElement.ChildNodes['CTe'].ChildNodes['infCte'];

  // Leitura das tags, considerando o namespace
  DadosResumoXML.Lines.Add('Valor do Frete: ' + XMLNode.ChildNodes['vPrest'].ChildNodes['vTPrest'].Text);
  DadosResumoXML.Lines.Add('Valor do ICMS: ' + XMLNode.ChildNodes['imp'].ChildNodes['ICMS'].ChildNodes['ICMS00'].ChildNodes['vICMS'].Text);
  DadosResumoXML.Lines.Add('Valor da Carga (mercadorias): ' + XMLNode.ChildNodes['infCarga'].ChildNodes['vCarga'].Text);
  DadosResumoXML.Lines.Add('Peso da Carga: ' + XMLNode.ChildNodes['infCarga'].ChildNodes['infQ'].ChildNodes['qCarga'].Text);
  DadosResumoXML.Lines.Add('Tipo de Medida (Bruto ou Cubado): ' + XMLNode.ChildNodes['infCarga'].ChildNodes['infQ'].ChildNodes['tpMed'].Text);
  DadosResumoXML.Lines.Add('Código da Unidade (Bruto ou Cubado): ' + XMLNode.ChildNodes['infCarga'].ChildNodes['infQ'].ChildNodes['cUnid'].Text);
end;

end.

