unit View.ConsultaCnpj;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, Vcl.StdCtrls, Vcl.Menus;

type
  TConsultaCnpj = class(TForm)
    Label1: TLabel;
    EditCnpj: TEdit;
    btnPesquisar: TButton;
    dados: TMemo;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Button1: TButton;
    procedure btnPesquisarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConsultaCnpj: TConsultaCnpj;

implementation

{$R *.dfm}

procedure TConsultaCnpj.btnPesquisarClick(Sender: TObject);
var
  CNPJLimpo: string;
begin
  dados.Clear;

  CNPJLimpo := StringReplace(EditCNPJ.Text, '.', '', [rfReplaceAll]);
  CNPJLimpo := StringReplace(CNPJLimpo, '-', '', [rfReplaceAll]);
  CNPJLimpo := StringReplace(CNPJLimpo, '/', '', [rfReplaceAll]);
  CNPJLimpo := StringReplace(CNPJLimpo, ' ', '', [rfReplaceAll]);

  RESTClient1.BaseURL := 'https://www.receitaws.com.br/v1/cnpj/' + CNPJLimpo;
  RESTRequest1.Execute;
  dados.Lines.Add(RESTRequest1.Response.JSONText);
end;

procedure TConsultaCnpj.Button1Click(Sender: TObject);
begin
  dados.Clear;
  EditCnpj.Clear;
  EditCnpj.SetFocus;
end;

procedure TConsultaCnpj.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = VK_ESCAPE then
    Close;
end;

procedure TConsultaCnpj.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

end.
