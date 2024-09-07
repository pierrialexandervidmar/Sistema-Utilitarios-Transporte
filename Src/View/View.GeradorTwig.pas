unit View.GeradorTwig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

type
  TGeradorTwig = class(TForm)
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    EditCNPJ: TEdit;
    EditNomeFantasia: TEdit;
    EditRazaoSocial: TEdit;
    EditCEP: TEdit;
    EditIdCidade: TEdit;
    EditLogradouro: TEdit;
    EditNumero: TEdit;
    EditBairro: TEdit;
    EditComplemento: TEdit;
    EditSigla: TEdit;
    EditPrazoAdicional: TEdit;
    BtnGerar: TButton;
    BtnLimpar: TButton;
    ResultadoTwig: TMemo;
    Label12: TLabel;
    Image1: TImage;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnLimparClick(Sender: TObject);
    procedure BtnGerarClick(Sender: TObject);
  private
    function CleanCepCnpj(const AText: string): string;
  public
    { Public declarations }
  end;

var
  GeradorTwig: TGeradorTwig;

implementation

function TGeradorTwig.CleanCepCnpj(const AText: string): string;
begin
  // Remove pontos, traços e espaços do texto, mantendo apenas números
  Result := Trim(StringReplace(AText, '.', '', [rfReplaceAll]));
  Result := StringReplace(Result, '-', '', [rfReplaceAll]);
  Result := StringReplace(Result, '/', '', [rfReplaceAll]);
  Result := StringReplace(Result, ' ', '', [rfReplaceAll]);
end;

{$R *.dfm}

procedure TGeradorTwig.BtnGerarClick(Sender: TObject);
begin
  // Monta o conteúdo do Twig com os valores coletados dos campos
  ResultadoTwig.Lines.Text :=
    'Cadastrando a pessoa' + sLineBreak +
    '{% set repositoryPessoa = em.getRepository(''\\Magamobi\\MagaZord\\Model\\Pessoa'') %}' + sLineBreak +
    '{% set pessoa = repositoryPessoa.findOneBy({"cpfCnpj":"' + Trim(EditCNPJ.Text) + '"}) %}' + sLineBreak +
    '{% if pessoa is null %}' + sLineBreak +
    '  {% set pessoa = newInstance(''\\Magamobi\\MagaZord\\Model\\PessoaJuridica'') %}' + sLineBreak +
    '  {{ pessoa.setNome(''' + Trim(EditNomeFantasia.Text) + ''') }}' + sLineBreak +
    '  {{ pessoa.setCpfCnpj(''' + Trim(EditCNPJ.Text) + ''') }}' + sLineBreak +
    '  {{ pessoa.setNomeRazaoSocial(''' + Trim(EditRazaoSocial.Text) + ''') }}' + sLineBreak +
    '  {{ pessoa.setNomeFantasia(''' + Trim(EditNomeFantasia.Text) + ''') }}' + sLineBreak +
    '  {% for tipo in [1,3] %}' + sLineBreak +
    '      {% set pessoaEndereco = pessoa.newPessoaEndereco() %}' + sLineBreak +
    '      {{ pessoaEndereco.setNomeDestinatario(''' + Trim(EditNomeFantasia.Text) + ''') }}' + sLineBreak +
    '      {% set cidade = em.find(''\\Magamobi\\MagaZord\\Model\\Cidade'', ' + Trim(EditIdCidade.Text) + ') %}' + sLineBreak +
    '      {{ pessoaEndereco.setCep(''' + CleanCepCnpj(EditCEP.Text) + ''') }}' + sLineBreak +
    '      {{ pessoaEndereco.setCidade(cidade) }}' + sLineBreak +
    '      {{ pessoaEndereco.setLogradouro(''' + Trim(EditLogradouro.Text) + ''') }}' + sLineBreak +
    '      {{ pessoaEndereco.setBairro(''' + Trim(EditBairro.Text) + ''') }}' + sLineBreak +
    '      {{ pessoaEndereco.setNumero(''' + CleanCepCnpj(EditNumero.Text) + ''') }}' + sLineBreak +
    '      {{ pessoaEndereco.setTipo(tipo) }}' + sLineBreak +
    '      {{ pessoaEndereco.setComplemento(''' + Trim(EditComplemento.Text) + ''') }}' + sLineBreak +
    '  {% endfor %}' + sLineBreak +
    '  {{ em.persist(pessoa) }}' + sLineBreak +
    '  Pessoa cadastrada' + sLineBreak +
    '{% else %}' + sLineBreak +
    '  Já existia pessoa cadastrada' + sLineBreak +
    '{% endif %}' + sLineBreak + sLineBreak +

    'Cadastrando a Transportadora' + sLineBreak +
    '{% set repositoryTransportadora = em.getRepository(''\\Magamobi\\MagaZord\\Model\\Transportadora'') %}' + sLineBreak +
    '{% set transportadora = repositoryTransportadora.findOneBy({"nome":"' + Trim(EditNomeFantasia.Text) + '"}) %}' + sLineBreak +
    '{% if transportadora is null %}' + sLineBreak +
    '    {% set transportadora = newInstance(''\\Magamobi\\MagaZord\\Model\\Transportadora'') %}' + sLineBreak +
    '    {{ transportadora.setNome(''' + Trim(EditNomeFantasia.Text) + ''') }}' + sLineBreak +
    '    {{ transportadora.setTipo(''34'') }}' + sLineBreak +
    '    {{ transportadora.setPessoa(pessoa) }}' + sLineBreak +
    '    {{ transportadora.getOpcoesGerais().setCodigoRastreioInterno(true) }}' + sLineBreak +
    '    {{ transportadora.getOpcoesGerais().setImprimeBarcodeRastreio(true) }}' + sLineBreak +
    '    {{ transportadora.getOpcoesGerais().setEnviaNotificacaoPortalTransporte(true) }}' + sLineBreak +
    '    {{ transportadora.getOpcoesGerais().setUtilizaEtiquetaPortalTransporte(true) }}' + sLineBreak +
    '    {{ em.persist(transportadora) }}' + sLineBreak +
    '  Cadastrado a Transportadora' + sLineBreak +
    '{% else %}' + sLineBreak +
    '  Transportadora já Cadastrada' + sLineBreak +
    '{% endif %}' + sLineBreak + sLineBreak +

    'Cadastrando o serviço da Transportadora' + sLineBreak +
    '{% set repositoryTransportadoraServico = em.getRepository(''\\Magamobi\\MagaZord\\Model\\TransportadoraServico'') %}' + sLineBreak +
    '{% set transportadoraServico = repositoryTransportadoraServico.findOneBy({"descricao":"' + Trim(EditNomeFantasia.Text) + '"}) %}' + sLineBreak +
    '{% if transportadoraServico is null %}' + sLineBreak +
    '    {% set transportadoraServico = newInstance(''\\Magamobi\\MagaZord\\Model\\TransportadoraServico'') %}' + sLineBreak +
    '    {{ transportadoraServico.setDescricao(''' + Trim(EditNomeFantasia.Text) + ''') }}' + sLineBreak +
    '    {{ transportadoraServico.setDescricaoSite(''' + Trim(EditNomeFantasia.Text) + ''') }}' + sLineBreak +
    '    {{ transportadoraServico.setTipo(''1'') }}' + sLineBreak +
    '    {{ transportadoraServico.setTransportadora(transportadora) }}' + sLineBreak +
    '    {{ transportadoraServico.setSomaFreteValorTotalPedido(true) }}' + sLineBreak +
    '    {{ transportadoraServico.setGeraComissaoMarketplace(false) }}' + sLineBreak +
    '    {{ em.persist(transportadoraServico) }}' + sLineBreak +
    '  Cadastrado a Transportadora Servico' + sLineBreak +
    '{% else %}' + sLineBreak +
    '  Transportadora Servico já Cadastrada' + sLineBreak +
    '{% endif %}' + sLineBreak + sLineBreak +

    'Cadastrando a Agência' + sLineBreak +
    '{% set repositoryTransportadoraAgencia = em.getRepository(''\\Magamobi\\MagaZord\\Model\\TransportadoraAgencia'') %}' + sLineBreak +
    '{% set transportadoraAgencia = repositoryTransportadoraAgencia.findOneBy({"nome":"' + Trim(EditNomeFantasia.Text) + '"}) %}' + sLineBreak +
    '{% if transportadoraAgencia is null %}' + sLineBreak +
    '      {% set transportadoraAgencia = newInstance(''\\Magamobi\\MagaZord\\Model\\TransportadoraAgencia'') %}' + sLineBreak +
    '      {{ transportadoraAgencia.setTransportadora(transportadora) }}' + sLineBreak +
    '      {{ transportadoraAgencia.setNome(''' + Trim(EditNomeFantasia.Text) + ''') }}' + sLineBreak +
    '      {{ transportadoraAgencia.setPessoa(pessoa) }}' + sLineBreak +
    '      {{ transportadoraAgencia.getOpcoesGerais().setUsaCalculoUnificado(true) }}' + sLineBreak +
    '      {{ transportadoraAgencia.getOpcoesPortalTransportes().setTipoCalculoFrete(''1'') }}' + sLineBreak +
    '  {% set transportadoraAgenciaServico = transportadoraAgencia.newTransportadoraAgenciaServico() %}' + sLineBreak +
    '      {{ transportadoraAgenciaServico.setTransportadoraServico(transportadoraServico) }}' + sLineBreak +
    '      {{ transportadoraAgenciaServico.setCodigoServico(''' + Trim(EditSigla.Text) + ''') }}' + sLineBreak +
    '      {{ transportadoraAgenciaServico.setPrazoAdicional(''' + Trim(EditPrazoAdicional.Text) + ''') }}' + sLineBreak +
    '      {{ transportadoraAgenciaServico.setAtivo(true) }}' + sLineBreak +
    '      {{ transportadoraAgenciaServico.getConfiguracao().setModalidadeFreteNF(0) }}' + sLineBreak +
    '  {{ em.persist(transportadoraAgencia) }}' + sLineBreak +
    '{% endif %}';
end;


procedure TGeradorTwig.BtnLimparClick(Sender: TObject);
begin
  EditCNPJ.Clear;
  EditNomeFantasia.Clear;
  EditRazaoSocial.Clear;
  EditCEP.Clear;
  EditIdCidade.Clear;
  EditLogradouro.Clear;
  EditNumero.Clear;
  EditBairro.Clear;
  EditComplemento.Clear;
  EditSigla.Clear;
  EditPrazoAdicional.Clear;

  ResultadoTwig.Clear;

  EditCNPJ.SetFocus;
end;


procedure TGeradorTwig.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

end.
