unit View.DeParaXmlCte;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.Dialogs, Vcl.Buttons, Xml.XMLDoc, Xml.XMLIntf,
  Xml.xmldom, Vcl.ExtCtrls, System.JSON;

type
  TDeParaXmlCte = class(TForm)
    OpenDialog1: TOpenDialog;
    BtnBuscarXML: TButton;
    lbl1: TLabel;
    lbl2: TLabel;
    DadosCotacao: TMemo;
    BtnAnalisar: TBitBtn;
    DadosResumoXML: TMemo;
    DadosResumoCotacao: TMemo;
    Label2: TLabel;
    lbl3: TLabel;
    XMLDocument1: TXMLDocument;
    pnl1: TPanel;
    LblCaminhoXML: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnBuscarXMLClick(Sender: TObject);
    procedure BtnAnalisarClick(Sender: TObject);
  private
    procedure LoadAndAnalyzeXML(const FileName: string);
    procedure AnalyzeCotacaoJSON;
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
    TaskMessageDlg('Atenção!', 'Por favor, selecione um arquivo XML primeiro.', mtWarning, [mbOK], 0);
  end;

  // Verifica se o Memo DadosCotacao contém algum texto
  if Trim(DadosCotacao.Lines.Text) <> '' then
  begin
    AnalyzeCotacaoJSON();
  end
  else
  begin
    TaskMessageDlg('Atenção!', 'Por favor, insira os dados JSON no campo "DadosCotacao" antes de continuar.', mtWarning, [mbOK], 0);
  end;
end;





procedure TDeParaXmlCte.BtnBuscarXMLClick(Sender: TObject);
var
  XMLFilePath: string;
begin
  if OpenDialog1.Execute then
  begin
    XMLFilePath := OpenDialog1.FileName;

    // Define o caminho do arquivo XML no caption do Label
    lblCaminhoXML.Caption := 'Caminho do XML: ' + XMLFilePath;
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
  XMLNode, NodeCarga, NodeInfQ, NodeVPrest, NodeComp: IXMLNode;
  I: Integer;
begin
  XMLDocument1.LoadFromFile(FileName);
  XMLDocument1.Active := True;

  // Limpa o memo
  DadosResumoXML.Clear;

  // Navega para o nó infCte
  XMLNode := XMLDocument1.DocumentElement.ChildNodes['CTe'].ChildNodes['infCte'];

  // Leitura das tags, considerando o namespace
  DadosResumoXML.Lines.Add('CEP de Origem: ' + XMLNode.ChildNodes['rem'].ChildNodes['enderReme'].ChildNodes['CEP'].Text);
  DadosResumoXML.Lines.Add('CEP de Destino: ' + XMLNode.ChildNodes['dest'].ChildNodes['enderDest'].ChildNodes['CEP'].Text);
  DadosResumoXML.Lines.Add('');
  DadosResumoXML.Lines.Add('Valor Total do Frete: ' + XMLNode.ChildNodes['vPrest'].ChildNodes['vTPrest'].Text);
  DadosResumoXML.Lines.Add('');
  DadosResumoXML.Lines.Add('Detalhamento do Valor:');
  DadosResumoXML.Lines.Add('Valor do ICMS: ' + XMLNode.ChildNodes['imp'].ChildNodes['ICMS'].ChildNodes['ICMS00'].ChildNodes['vICMS'].Text);

  // Acessa o nó vPrest
  NodeVPrest := XMLNode.ChildNodes['vPrest'];

  // Percorre todos os nós Comp
  for I := 0 to NodeVPrest.ChildNodes.Count - 1 do
  begin
    if NodeVPrest.ChildNodes[I].NodeName = 'Comp' then
    begin
      NodeComp := NodeVPrest.ChildNodes[I];
      DadosResumoXML.Lines.Add('=========================');
      DadosResumoXML.Lines.Add('Tipo: ' + NodeComp.ChildNodes['xNome'].Text);
      DadosResumoXML.Lines.Add('Resultado: ' + NodeComp.ChildNodes['vComp'].Text);
    end;
  end;



  DadosResumoXML.Lines.Add('');
  DadosResumoXML.Lines.Add('Informações de Carga: ');
  DadosResumoXML.Lines.Add('Valor da Carga (mercadorias): ' + XMLNode.ChildNodes['infCTeNorm'].ChildNodes['infCarga'].ChildNodes['vCarga'].Text);

  // Acessa o nó infCarga
  NodeCarga := XMLNode.ChildNodes['infCTeNorm'].ChildNodes['infCarga'];

  // Percorre todos os nós infQ
  for I := 0 to NodeCarga.ChildNodes.Count - 1 do
  begin
    if NodeCarga.ChildNodes[I].NodeName = 'infQ' then
    begin
      NodeInfQ := NodeCarga.ChildNodes[I];
      DadosResumoXML.Lines.Add('=========================');
      DadosResumoXML.Lines.Add('Tipo: ' + NodeInfQ.ChildNodes['tpMed'].Text);
      DadosResumoXML.Lines.Add('Resultado: ' + NodeInfQ.ChildNodes['qCarga'].Text);
    end;
  end;

end;


procedure TDeParaXmlCte.AnalyzeCotacaoJSON;
var
  JSONObj, DetalheObj: TJSONObject;
  DetalhesArray: TJSONArray;
  I: Integer;
  JSONStr: string;
begin
  // Limpa o memo de resumo
  DadosResumoCotacao.Clear;

  // Carrega o conteúdo do Memo DadosCotacao em uma string e remove espaços ou quebras de linha
  JSONStr := Trim(DadosCotacao.Lines.Text);

  try
    // Faz o parse do JSON para um objeto JSON
    JSONObj := TJSONObject.ParseJSONValue(JSONStr) as TJSONObject;

    if JSONObj = nil then
    begin
      DadosResumoCotacao.Lines.Add('Erro ao interpretar o JSON.');
      Exit;
    end;

    // Imprime os dados gerais
    DadosResumoCotacao.Lines.Add('Código: ' + JSONObj.GetValue('codigo').Value);
    DadosResumoCotacao.Lines.Add('Transportadora: ' + JSONObj.GetValue('nomeTransportadora').Value);
    DadosResumoCotacao.Lines.Add('Valor do Frete: ' + JSONObj.GetValue('valor').Value);
    DadosResumoCotacao.Lines.Add('Prazo Inicial: ' + JSONObj.GetValue('prazoInicial').Value);
    DadosResumoCotacao.Lines.Add('Prazo Final: ' + JSONObj.GetValue('prazoFinal').Value);
    DadosResumoCotacao.Lines.Add('');

    // Acessa o array 'detalhes'
    DetalhesArray := JSONObj.GetValue('detalhes') as TJSONArray;

    // Percorre o array 'detalhes' e imprime cada item
    DadosResumoCotacao.Lines.Add('Detalhes:');
    for I := 0 to DetalhesArray.Count - 1 do
    begin
      DetalheObj := DetalhesArray.Items[I] as TJSONObject;
      DadosResumoCotacao.Lines.Add('=========================');
      DadosResumoCotacao.Lines.Add('Nome: ' + DetalheObj.GetValue('nome').Value);
      DadosResumoCotacao.Lines.Add('Valor: ' + DetalheObj.GetValue('valor').Value);
      DadosResumoCotacao.Lines.Add('Descrição: ' + DetalheObj.GetValue('descricao').Value);
    end;

  except
    on E: Exception do
    begin
      DadosResumoCotacao.Lines.Add('Erro ao processar o JSON: ' + E.Message);
    end;
  end;

  // Libera o objeto JSON da memória
  JSONObj.Free;
end;

end.

