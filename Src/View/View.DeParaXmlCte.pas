unit View.DeParaXmlCte;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.Dialogs;

type
  TDeParaXmlCte = class(TForm)
    OpenDialog1: TOpenDialog;
    Button1: TButton;
    Label1: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DeParaXmlCte: TDeParaXmlCte;

implementation

{$R *.dfm}

procedure TDeParaXmlCte.Button1Click(Sender: TObject);
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

end.
