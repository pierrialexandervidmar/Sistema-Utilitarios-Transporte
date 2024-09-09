unit View.CalculoPortalTransportes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, System.JSON;

type
  TCalculoPortalTransportes = class(TForm)
    Label1: TLabel;
    EditTokenAdmin: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    EditCepOrigem: TEdit;
    EditCepDestino: TEdit;
    Label4: TLabel;
    EditValor: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    EditPeso: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    EditAltura: TEdit;
    EditLargura: TEdit;
    EditComprimento: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    EditSigla: TEdit;
    DadosCalculoFrete: TMemo;
    Label13: TLabel;
    BtnConsultar: TButton;
    BtnLimpar: TButton;
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
  CalculoPortalTransportes: TCalculoPortalTransportes;

implementation

{$R *.dfm}

procedure TCalculoPortalTransportes.BtnConsultarClick(Sender: TObject);
var
  JSONBody: TJSONObject;
  JSONProduto, JSONVolumeDetalhes: TJSONObject;
  JSONArrayProdutos, JSONArrayServicos, JSONArrayVolumesDetalhes: TJSONArray;
  JSONResponse, JSONRequest: TJSONObject;
  FormattedJSON: string;
  CEPOrigemFormatado, CEPDestinoFormatado: string;
begin
  // Limpar o memo antes de exibir os resultados da nova requisição
  DadosCalculoFrete.Clear;

  // Formatamos os campos de CEP para vir sem caracteres e espaçamentos
  CEPOrigemFormatado := StringReplace(EditCepOrigem.Text, '.', '', [rfReplaceAll]);
  CEPOrigemFormatado := StringReplace(CEPOrigemFormatado, '-', '', [rfReplaceAll]);
  CEPOrigemFormatado := StringReplace(CEPOrigemFormatado, '/', '', [rfReplaceAll]);
  CEPOrigemFormatado := StringReplace(CEPOrigemFormatado, ' ', '', [rfReplaceAll]);

  CEPDestinoFormatado := StringReplace(EditCepDestino.Text, '.', '', [rfReplaceAll]);
  CEPDestinoFormatado := StringReplace(CEPDestinoFormatado, '-', '', [rfReplaceAll]);
  CEPDestinoFormatado := StringReplace(CEPDestinoFormatado, '/', '', [rfReplaceAll]);
  CEPDestinoFormatado := StringReplace(CEPDestinoFormatado, ' ', '', [rfReplaceAll]);

  // Definir a URL base do cliente REST
  RESTClient1.BaseURL := 'https://api-transporte.magazord.com.br/api/v1/calculoFrete';

  // Limpar parâmetros existentes para evitar conflitos de requisições anteriores
  RESTRequest1.Params.Clear;

  // Adicionar o header de Content-Type para JSON
  RESTRequest1.Params.AddItem('Content-Type', 'application/json', TRESTRequestParameterKind.pkHTTPHEADER, [poDoNotEncode]);

  // Criar o objeto JSON para o corpo da requisição
  JSONBody := TJSONObject.Create;
  try
    JSONBody.AddPair('cliente', EditTokenAdmin.Text);
    JSONBody.AddPair('cepOrigem', CEPOrigemFormatado);
    JSONBody.AddPair('cepDestino', CEPDestinoFormatado);
    JSONBody.AddPair('dimensaoCalculo', 'altura');
    JSONBody.AddPair('valorDeclarado', TJSONNumber.Create(StrToFloat(EditValor.Text)));

    // Criar JSON para o produto
    JSONProduto := TJSONObject.Create;
    JSONProduto.AddPair('altura', TJSONNumber.Create(StrToFloat(EditAltura.Text)));
    JSONProduto.AddPair('largura', TJSONNumber.Create(StrToFloat(EditLargura.Text)));
    JSONProduto.AddPair('comprimento', TJSONNumber.Create(StrToFloat(EditComprimento.Text)));
    JSONProduto.AddPair('peso', TJSONNumber.Create(StrToFloat(EditPeso.Text)));
    JSONProduto.AddPair('quantidade', TJSONNumber.Create(1)); // Por exemplo, fixado como 1
    JSONProduto.AddPair('valor', TJSONNumber.Create(StrToFloat(EditValor.Text)));
    JSONProduto.AddPair('volumes', TJSONNumber.Create(1)); // Por exemplo, fixado como 1

    // Criar JSON Array para produtos
    JSONArrayProdutos := TJSONArray.Create;
    JSONArrayProdutos.AddElement(JSONProduto);

    // Adicionar produtos ao JSON Body
    JSONBody.AddPair('produtos', JSONArrayProdutos);

    // Criar JSON Array para servicos
    JSONArrayServicos := TJSONArray.Create;
    JSONArrayServicos.AddElement(TJSONString.Create(EditSigla.Text)); // Adiciona o serviço como string ao array

    // Adicionar servicos ao JSON Body
    JSONBody.AddPair('servicos', JSONArrayServicos);

    // Definir o corpo da requisição com o JSON construído
    RESTRequest1.AddBody(JSONBody.ToString, TRESTContentType.ctAPPLICATION_JSON);

    // Configurar o método HTTP como POST
    RESTRequest1.Method := TRESTRequestMethod.rmPOST;

    try
      // Executar a requisição
      RESTRequest1.Execute;

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
              // Formatar o JSON para ser mais legível
              FormattedJSON := JSONResponse.Format(2);  // Usando uma indentação de 2 espaços

              // Exibir JSON formatado no Memo
              DadosCalculoFrete.Lines.Text := FormattedJSON;

              // Damos um espamento e adicionamos o Json do Payload da Requisição abaixo, para conferência
              DadosCalculoFrete.Lines.Add('');
              DadosCalculoFrete.Lines.Add('');
              DadosCalculoFrete.Lines.Add('');
              DadosCalculoFrete.Lines.Add('');
              DadosCalculoFrete.Lines.Add('ABAIXO SEGUE PAYLOAD DA REQUISIÇÃO ENVIADA, PARA CONFERÊNCIA: ');
              DadosCalculoFrete.Lines.Add(JSONRequest.Format(2));
            finally
              JSONResponse.Free;
            end;
          end
          else
          begin
            // Exibir resposta original caso o parse falhe
            DadosCalculoFrete.Lines.Text := RESTResponse1.Content;
          end;
        except
          on E: Exception do
            ShowMessage('Erro ao formatar JSON: ' + E.Message);
        end;
      end
      else
      begin
        DadosCalculoFrete.Lines.Add('Erro na requisição: ' + RESTResponse1.StatusText);
        DadosCalculoFrete.Lines.Add('Código de status: ' + IntToStr(RESTResponse1.StatusCode));
      end;
    except
      on E: ERESTException do
      begin
        DadosCalculoFrete.Lines.Add('Erro na requisição REST: ' + E.Message);
      end;
      on E: Exception do
      begin
        DadosCalculoFrete.Lines.Add('Erro inesperado: ' + E.Message);
      end;
    end;

  finally
    // Liberar memória do JSON
    JSONBody.Free;
  end;
end;



procedure TCalculoPortalTransportes.BtnLimparClick(Sender: TObject);
begin
  // Limpar todos os campos de entrada
  EditTokenAdmin.Clear;
  EditCepOrigem.Clear;
  EditCepDestino.Clear;
  EditValor.Clear;
  EditPeso.Clear;
  EditAltura.Clear;
  EditLargura.Clear;
  EditComprimento.Clear;
  EditSigla.Clear;

  // Limpar o memo que contém os dados do cálculo de frete
  DadosCalculoFrete.Clear;

  // Focar no primeiro campo de entrada, por exemplo, EditTokenAdmin
  EditTokenAdmin.SetFocus;
end;

procedure TCalculoPortalTransportes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

end.
