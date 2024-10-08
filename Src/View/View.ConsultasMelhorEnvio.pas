unit View.ConsultasMelhorEnvio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, System.JSON, REST.Response.Adapter,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls;  // Adicionei System.JSON aqui

type
  TConsultasMelhorEnvio = class(TForm)
    Label1: TLabel;
    BtnConsultarCompanies: TButton;
    DadosCompanies: TMemo;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Label2: TLabel;
    EditID: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    EditUF: TEdit;
    BtnConsultarAgency: TButton;
    DadosAgency: TMemo;
    RESTClient2: TRESTClient;
    RESTRequest2: TRESTRequest;
    RESTResponse2: TRESTResponse;
    EditCidade: TEdit;
    Label5: TLabel;
    Image1: TImage;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnConsultarCompaniesClick(Sender: TObject);
    procedure BtnConsultarAgencyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConsultasMelhorEnvio: TConsultasMelhorEnvio;

implementation

{$R *.dfm}

procedure TConsultasMelhorEnvio.BtnConsultarAgencyClick(Sender: TObject);
var
  JSONValue: TJSONValue;
  JSONArray: TJSONArray;
  AgencyObj, AddressObj: TJSONObject;
  i, AgencyId: Integer;
  AgencyName, PostalCode: string;
  BaseURL: string;
begin
  DadosAgency.Clear;

  // Configurando o cliente REST
  if EditCidade.Text <> '' then
    BaseURL := 'https://melhorenvio.com.br/api/v2/me/shipment/agencies?company=' + EditID.Text + '&state=' + EditUF.Text + '&city=' + EditCidade.Text
  else
    BaseURL := 'https://melhorenvio.com.br/api/v2/me/shipment/agencies?company=' + EditID.Text + '&state=' + EditUF.Text;

  RESTClient2.BaseURL := BaseURL;
  RESTRequest2.Method := TRESTRequestMethod.rmGET; // Define o m�todo como GET
  RESTRequest2.Client := RESTClient2;
  RESTRequest2.Response := RESTResponse2;

  try
    // Executa a requisi��o
    RESTRequest2.Execute;

    // Verifica se a resposta est� em JSON
    if RESTResponse2.StatusCode = 200 then
    begin
      try
        // Parseia a resposta para JSON
        JSONValue := TJSONObject.ParseJSONValue(RESTResponse2.Content);

        // Verifica se JSONValue n�o � nulo e � uma inst�ncia de TJSONArray
        if Assigned(JSONValue) and (JSONValue is TJSONArray) then
        begin
          JSONArray := JSONValue as TJSONArray;
          for i := 0 to JSONArray.Count - 1 do
          begin
            // Cada item no array � um objeto JSON de uma empresa
            AgencyObj := JSONArray.Items[i] as TJSONObject;

            if Assigned(AgencyObj.Values['id']) then
              AgencyId := AgencyObj.GetValue<Integer>('id')
            else
              AgencyId := 0;


            if Assigned(AgencyObj.Values['name']) then
              AgencyName := AgencyObj.GetValue<string>('name')
            else
              AgencyName := 'N/A';


            // Verifica se 'address' existe e obt�m o 'postal_code'
            if Assigned(AgencyObj.Values['address']) then
            begin
              AddressObj := AgencyObj.GetValue<TJSONObject>('address');
              if Assigned(AddressObj.Values['postal_code']) then
                PostalCode := AddressObj.GetValue<string>('postal_code')
              else
                PostalCode := 'N/A';
            end
            else
            begin
              PostalCode := 'N/A';
            end;

            // Exibir o id da empresa
            DadosAgency.Lines.Add('Id: ' + IntToStr(AgencyId));
            // Exibir o nome da empresa
            DadosAgency.Lines.Add('Ag�ncia: ' + AgencyName);
            // Exibir o c�digo postal
            DadosAgency.Lines.Add('C�digo Postal: ' + PostalCode);

            DadosAgency.Lines.Add(''); // Linha em branco para separar empresas
          end;
        end
        else
        begin
          ShowMessage('A resposta JSON n�o � um array ou � inv�lida.');
        end;
      except
        on E: Exception do
          ShowMessage('Erro ao processar a resposta JSON: ' + E.Message);
      end;
    end
    else
    begin
      // Exibe a mensagem de erro se o status n�o for 200
      ShowMessage('Aten��o: Sem Conte�do para a Localidade (C�digo: ' + IntToStr(RESTResponse2.StatusCode) + ')');
    end;
  finally
    JSONValue.Free;
  end;
end;




procedure TConsultasMelhorEnvio.BtnConsultarCompaniesClick(Sender: TObject);
var
  JSONValue: TJSONValue;
  JSONArray: TJSONArray;
  CompanyObj: TJSONObject;
  ServiceArray: TJSONArray;
  ServiceObj: TJSONObject;
  i, j, CompanyId: Integer;
  CompanyName, ServiceName: string;
begin
  DadosCompanies.Clear;

  // Configurando o cliente REST
  RESTClient1.BaseURL := 'https://melhorenvio.com.br/api/v2/me/shipment/companies';
  RESTRequest1.Method := TRESTRequestMethod.rmGET; // Define o m�todo como GET
  RESTRequest1.Client := RESTClient1;
  RESTRequest1.Response := RESTResponse1;

  try
    // Executa a requisi��o
    RESTRequest1.Execute;

    // Verifica se a resposta est� em JSON e v�lida
    if RESTResponse1.StatusCode = 200 then
    begin
      try
        // Parseia a resposta para JSON
        JSONValue := TJSONObject.ParseJSONValue(RESTResponse1.Content);

        if Assigned(JSONValue) and (JSONValue is TJSONArray) then
        begin
          JSONArray := JSONValue as TJSONArray;
          for i := 0 to JSONArray.Count - 1 do
          begin
            // Cada item no array � um objeto JSON de uma empresa
            CompanyObj := JSONArray.Items[i] as TJSONObject;
            CompanyName := CompanyObj.GetValue<string>('name');
            CompanyId := CompanyObj.GetValue<Integer>('id');

            // Exibir o id da empresa
            DadosCompanies.Lines.Add('Id: ' + IntToStr(CompanyId));
            // Exibir o nome da empresa
            DadosCompanies.Lines.Add('Empresa: ' + CompanyName);

            // Acessar os servi�os dessa empresa
            ServiceArray := CompanyObj.GetValue<TJSONArray>('services');
            if Assigned(ServiceArray) then
            begin
              for j := 0 to ServiceArray.Count - 1 do
              begin
                ServiceObj := ServiceArray.Items[j] as TJSONObject;
                ServiceName := ServiceObj.GetValue<string>('name');

                // Exibir o nome de cada servi�o
                DadosCompanies.Lines.Add('  Servi�o: ' + ServiceName);
              end;
            end;
            DadosCompanies.Lines.Add(''); // Linha em branco para separar empresas
          end;
        end
        else
        begin
          ShowMessage('A resposta JSON n�o � um array ou � inv�lida.');
        end;
      except
        on E: Exception do
          ShowMessage('Erro ao processar a resposta JSON: ' + E.Message);
      end;
    end
    else
    begin
      // Exibe a mensagem de erro se o status n�o for 200
      ShowMessage('Erro na requisi��o: ' + RESTResponse1.StatusText + ' (C�digo: ' + IntToStr(RESTResponse1.StatusCode) + ')');
    end;
  except
    on E: Exception do
    begin
      ShowMessage('Erro ao executar a requisi��o: ' + E.Message);
    end;
  end;
end;


procedure TConsultasMelhorEnvio.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_ESCAPE then
    Close;
end;

end.

