unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, REST.Types,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, View.ConsultaCnpj, View.ConsultasMelhorEnvio, View.CalculoPortalTransportes,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ComCtrls, View.ConsultaCredencialAzul, View.ConsultaServicosKangu, View.ConsultasServicosFlixLog, View.ConsultaOcorrenciaBuslog,
  View.TesteSSW, View.GerarTokenJWT, View.DeParaXmlCte, View.ConsultaOcorrenciaAzul, View.ConsultaOcorrenciaBraspress, View.ConsultaOcorrenciaDaytona, View.AutenticarCorreios;

type
  TFormPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Configuraes1: TMenuItem;
    Porta1: TMenuItem;
    Utilitrios1: TMenuItem;
    ConsultaCNPJ1: TMenuItem;
    Sair1: TMenuItem;
    MelhorEnvio1: TMenuItem;
    AnlisedeCotaes1: TMenuItem;
    ValidadordeCSV1: TMenuItem;
    GeradordeTwig1: TMenuItem;
    ValidarCredencialAzul1: TMenuItem;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    CotaoviaPortaldeTransportes1: TMenuItem;
    Ferramentas1: TMenuItem;
    otalizadordeCTEs1: TMenuItem;
    ConsultarServiosKangu1: TMenuItem;
    Label1: TLabel;
    ConsultasFlixlogServios1: TMenuItem;
    esteCotaoAPIdaSSW1: TMenuItem;
    Image1: TImage;
    Image2: TImage;
    GerarLinkJWTPortalBW1: TMenuItem;
    Ocorrncias1: TMenuItem;
    Openlog1: TMenuItem;
    Braspress1: TMenuItem;
    Carriers1: TMenuItem;
    Daytona1: TMenuItem;
    Jadlog1: TMenuItem;
    Openlog2: TMenuItem;
    SSW1: TMenuItem;
    otalXMLxTotalCotao1: TMenuItem;
    estedeAutenticaoCorreios1: TMenuItem;
    Buslog1: TMenuItem;
    procedure Sair1Click(Sender: TObject);
    procedure ConsultaCNPJ1Click(Sender: TObject);
    procedure MelhorEnvio1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ValidarCredencialAzul1Click(Sender: TObject);
    procedure ConsultarServiosKangu1Click(Sender: TObject);
    procedure CotaoviaPortaldeTransportes1Click(Sender: TObject);
    procedure ConsultasFlixlogServios1Click(Sender: TObject);
    procedure esteCotaoAPIdaSSW1Click(Sender: TObject);
    procedure GerarLinkJWTPortalBW1Click(Sender: TObject);
    procedure otalXMLxTotalCotao1Click(Sender: TObject);
    procedure Openlog1Click(Sender: TObject);
    procedure Braspress1Click(Sender: TObject);
    procedure Daytona1Click(Sender: TObject);
    procedure estedeAutenticaoCorreios1Click(Sender: TObject);
    procedure Buslog1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;
  FormCNPJ: TConsultaCnpj;
  FormConsultasMelhorEnvio: TConsultasMelhorEnvio;
  FormConsultaCredencialAzul: TConsultaCredencialAzul;
  FormConsultaServicosKangu: TConsultaServicosKangu;
  FormCalculoPortalTransportes: TCalculoPortalTransportes;
  FormConsultaServicosFlixLog: TConsultasServicosFlixLog;
  FormTesteSSW: TTesteSSW;
  FormGerarTokenJWT: TGerarTokenJWT;
  FormDeParaXmlCte: TDeParaXmlCte;
  FormConsultaOcorrenciaAzul: TConsultaOcorrenciaAzul;
  FormConsultaOcorrenciaBraspress: TConsultaOcorrenciaBraspress;
  FormConsultaOcorrenciaDaytona: TConsultaOcorrenciaDaytona;
  FormAutenticarCorreios: TAutenticarCorreios;
  FormConsultaOcorrenciaBuslog: TConsultaOcorrenciaBuslog;
implementation

{$R *.dfm}





procedure TFormPrincipal.Braspress1Click(Sender: TObject);
begin
  FormConsultaOcorrenciaBraspress := TConsultaOcorrenciaBraspress.Create(Self);
  try
    FormConsultaOcorrenciaBraspress.ShowModal;
  finally
    FormConsultaOcorrenciaBraspress.Free; // Libera a mem�ria
  end;
end;

procedure TFormPrincipal.Buslog1Click(Sender: TObject);
begin
  FormConsultaOcorrenciaBuslog := TConsultaOcorrenciaBuslog.Create(Self);
  try
    FormConsultaOcorrenciaBuslog.ShowModal;
  finally
    FormConsultaOcorrenciaBuslog.Free; // Libera a mem�ria usada
  end;
end;

procedure TFormPrincipal.ConsultaCNPJ1Click(Sender: TObject);
begin
  FormCNPJ := TConsultaCnpj.Create(Self);
  try
    FormCNPJ.ShowModal;
  finally
    FormCNPJ.Free; // Libera a mem�ria
  end;
end;

procedure TFormPrincipal.ConsultarServiosKangu1Click(Sender: TObject);
begin
  FormConsultaServicosKangu := TConsultaServicosKangu.Create(Self);
  try
    FormConsultaServicosKangu.ShowModal;
  finally
    FormConsultaServicosKangu.Free; // Libera a mem�ria usada
  end;
end;

procedure TFormPrincipal.ConsultasFlixlogServios1Click(Sender: TObject);
begin
  FormConsultaServicosFlixLog := TConsultasServicosFlixLog.Create(Self);
  try
    FormConsultaServicosFlixLog.ShowModal;
  finally
    FormConsultaServicosFlixLog.Free; // Libera a mem�ria usada
  end;
end;

procedure TFormPrincipal.CotaoviaPortaldeTransportes1Click(Sender: TObject);
begin
  FormCalculoPortalTransportes := TCalculoPortalTransportes.Create(Self);
  try
    FormCalculoPortalTransportes.ShowModal;
  finally
    FormCalculoPortalTransportes.Free; // Libera a mem�ria usada
  end;
end;

procedure TFormPrincipal.Daytona1Click(Sender: TObject);
begin
  FormConsultaOcorrenciaDaytona := TConsultaOcorrenciaDaytona.Create(Self);
  try
    FormConsultaOcorrenciaDaytona.ShowModal;
  finally
    FormConsultaOcorrenciaDaytona.Free; // Libera a mem�ria usada
  end;
end;

procedure TFormPrincipal.esteCotaoAPIdaSSW1Click(Sender: TObject);
begin
  FormTesteSSW := TTesteSSW.Create(Self);
  try
    FormTesteSSW.ShowModal;
  finally
    FormTesteSSW.Free; // Libera a mem�ria usada
  end;
end;

procedure TFormPrincipal.estedeAutenticaoCorreios1Click(Sender: TObject);
begin
  FormAutenticarCorreios := TAutenticarCorreios.Create(Self);
  try
    FormAutenticarCorreios.ShowModal;
  finally
    FormAutenticarCorreios.Free; // Libera a mem�ria usada
  end;
end;

procedure TFormPrincipal.GerarLinkJWTPortalBW1Click(Sender: TObject);
begin
  FormGerarTokenJWT := TGerarTokenJWT.Create(Self);
  try
    FormGerarTokenJWT.ShowModal;
  finally
    FormGerarTokenJWT.Free; // Libera a mem�ria usada
  end;
end;

procedure TFormPrincipal.MelhorEnvio1Click(Sender: TObject);
begin
  FormConsultasMelhorEnvio := TConsultasMelhorEnvio.Create(Self);
  try
    FormConsultasMelhorEnvio.ShowModal;
  finally
    FormConsultasMelhorEnvio.Free; // Libera a mem�ria usada
  end;
end;

procedure TFormPrincipal.Openlog1Click(Sender: TObject);
begin
  FormConsultaOcorrenciaAzul := TConsultaOcorrenciaAzul.Create(Self);
  try
    FormConsultaOcorrenciaAzul.ShowModal;
  finally
    FormConsultaOcorrenciaAzul.Free; // Libera a mem�ria usada
  end;
end;

procedure TFormPrincipal.otalXMLxTotalCotao1Click(Sender: TObject);
begin
  FormDeParaXmlCte := TDeParaXmlCte.Create(Self);
  try
    FormDeParaXmlCte.ShowModal;
  finally
    FormDeParaXmlCte.Free; // Libera a mem�ria usada
  end;
end;

procedure TFormPrincipal.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFormPrincipal.Timer1Timer(Sender: TObject);
begin
  StatusBar1.Panels[2].Text := DateTimeToStr(Now);
end;

procedure TFormPrincipal.ValidarCredencialAzul1Click(Sender: TObject);
begin
  FormConsultaCredencialAzul := TConsultaCredencialAzul.Create(Self);
  try
    FormConsultaCredencialAzul.ShowModal;
  finally
    FormConsultaCredencialAzul.Free; // Libera a mem�ria usada
  end;
end;

end.
