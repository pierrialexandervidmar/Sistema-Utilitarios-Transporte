unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, REST.Types,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, View.ConsultaCnpj, View.ConsultasMelhorEnvio, View.CalculoPortalTransportes,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ComCtrls, View.ConsultaCredencialAzul, View.ConsultaServicosKangu, View.ConsultasServicosFlixLog, View.ConsultaOcorrenciaBuslog,
  View.TesteSSW, View.GerarTokenJWT, View.DeParaXmlCte, View.ConsultaOcorrenciaAzul, View.ConsultaOcorrenciaBraspress, View.ConsultaOcorrenciaDaytona, View.AutenticarCorreios,
  View.ConsultaOcorrenciaJadlog, View.CotacaoJadlog, View.ConsultaOcorrenciaOpenlog, View.GeradorTwig, View.CotacaoOpenlogEngloba, View.ConsultaOcorrenciaCarriers;

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
    Azul1: TMenuItem;
    Braspress1: TMenuItem;
    Carriers1: TMenuItem;
    Daytona1: TMenuItem;
    Jadlog1: TMenuItem;
    SSW1: TMenuItem;
    otalXMLxTotalCotao1: TMenuItem;
    estedeAutenticaoCorreios1: TMenuItem;
    Buslog1: TMenuItem;
    Cotaes1: TMenuItem;
    JadLog2: TMenuItem;
    SSW2: TMenuItem;
    NT1: TMenuItem;
    OpenlogEngloba1: TMenuItem;
    OpenlogEngloba2: TMenuItem;
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
    procedure Braspress1Click(Sender: TObject);
    procedure Daytona1Click(Sender: TObject);
    procedure estedeAutenticaoCorreios1Click(Sender: TObject);
    procedure Buslog1Click(Sender: TObject);
    procedure Jadlog1Click(Sender: TObject);
    procedure SSW2Click(Sender: TObject);
    procedure JadLog2Click(Sender: TObject);
    procedure OpenlogEngloba1Click(Sender: TObject);
    procedure Azul1Click(Sender: TObject);
    procedure GeradordeTwig1Click(Sender: TObject);
    procedure OpenlogEngloba2Click(Sender: TObject);
    procedure Carriers1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
  FormConsultaOcorrenciaJadlog: TFormConsultaOcorrenciaJadlog;
  FormCotacaoJadlog: TCotacaoJadlog;
  FormConsultaOcorrenciaOpenlog: TConsultaOcorrenciaOpenlog;
  FormGeradorTwig: TGeradorTwig;
  FormCotacaoOpenlogEngloba: TCotacaoOpenlogEngloba;
  FormConsultaOcorrenciaCarriers: TConsultaOcorrenciaCarriers;
implementation

{$R *.dfm}





procedure TFormPrincipal.Braspress1Click(Sender: TObject);
begin
  FormConsultaOcorrenciaBraspress := TConsultaOcorrenciaBraspress.Create(Self);
  try
    FormConsultaOcorrenciaBraspress.ShowModal;
  finally
    FormConsultaOcorrenciaBraspress.Free; // Libera a memória
  end;
end;

procedure TFormPrincipal.Buslog1Click(Sender: TObject);
begin
  FormConsultaOcorrenciaBuslog := TConsultaOcorrenciaBuslog.Create(Self);
  try
    FormConsultaOcorrenciaBuslog.ShowModal;
  finally
    FormConsultaOcorrenciaBuslog.Free; // Libera a memória usada
  end;
end;

procedure TFormPrincipal.Carriers1Click(Sender: TObject);
begin
  FormConsultaOcorrenciaCarriers := TConsultaOcorrenciaCarriers.Create(Self);
  try
    FormConsultaOcorrenciaCarriers.ShowModal;
  finally
    FormConsultaOcorrenciaCarriers.Free; // Libera a memória usada
  end;
end;

procedure TFormPrincipal.ConsultaCNPJ1Click(Sender: TObject);
begin
  FormCNPJ := TConsultaCnpj.Create(Self);
  try
    FormCNPJ.ShowModal;
  finally
    FormCNPJ.Free; // Libera a memória
  end;
end;

procedure TFormPrincipal.ConsultarServiosKangu1Click(Sender: TObject);
begin
  FormConsultaServicosKangu := TConsultaServicosKangu.Create(Self);
  try
    FormConsultaServicosKangu.ShowModal;
  finally
    FormConsultaServicosKangu.Free; // Libera a memória usada
  end;
end;

procedure TFormPrincipal.ConsultasFlixlogServios1Click(Sender: TObject);
begin
  FormConsultaServicosFlixLog := TConsultasServicosFlixLog.Create(Self);
  try
    FormConsultaServicosFlixLog.ShowModal;
  finally
    FormConsultaServicosFlixLog.Free; // Libera a memória usada
  end;
end;

procedure TFormPrincipal.CotaoviaPortaldeTransportes1Click(Sender: TObject);
begin
  FormCalculoPortalTransportes := TCalculoPortalTransportes.Create(Self);
  try
    FormCalculoPortalTransportes.ShowModal;
  finally
    FormCalculoPortalTransportes.Free; // Libera a memória usada
  end;
end;

procedure TFormPrincipal.Daytona1Click(Sender: TObject);
begin
  FormConsultaOcorrenciaDaytona := TConsultaOcorrenciaDaytona.Create(Self);
  try
    FormConsultaOcorrenciaDaytona.ShowModal;
  finally
    FormConsultaOcorrenciaDaytona.Free; // Libera a memória usada
  end;
end;

procedure TFormPrincipal.esteCotaoAPIdaSSW1Click(Sender: TObject);
begin
  FormTesteSSW := TTesteSSW.Create(Self);
  try
    FormTesteSSW.ShowModal;
  finally
    FormTesteSSW.Free; // Libera a memória usada
  end;
end;

procedure TFormPrincipal.estedeAutenticaoCorreios1Click(Sender: TObject);
begin
  FormAutenticarCorreios := TAutenticarCorreios.Create(Self);
  try
    FormAutenticarCorreios.ShowModal;
  finally
    FormAutenticarCorreios.Free; // Libera a memória usada
  end;
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
end;

procedure TFormPrincipal.GeradordeTwig1Click(Sender: TObject);
begin
  FormGeradorTwig := TGeradorTwig.Create(Self);
  try
    FormGeradorTwig.ShowModal;
  finally
    FormGeradorTwig.Free; // Libera a memória usada
  end;
end;

procedure TFormPrincipal.GerarLinkJWTPortalBW1Click(Sender: TObject);
begin
  FormGerarTokenJWT := TGerarTokenJWT.Create(Self);
  try
    FormGerarTokenJWT.ShowModal;
  finally
    FormGerarTokenJWT.Free; // Libera a memória usada
  end;
end;

procedure TFormPrincipal.Jadlog1Click(Sender: TObject);
begin
  FormConsultaOcorrenciaJadlog := TFormConsultaOcorrenciaJadlog.Create(Self);
  try
    FormConsultaOcorrenciaJadlog.ShowModal;
  finally
    FormConsultaOcorrenciaJadlog.Free; // Libera a memória usada
  end;
end;

procedure TFormPrincipal.JadLog2Click(Sender: TObject);
begin
  FormCotacaoJadlog := TCotacaoJadlog.Create(Self);
  try
    FormCotacaoJadlog.ShowModal;
  finally
    FormCotacaoJadlog.Free; // Libera a memória usada
  end;
end;

procedure TFormPrincipal.MelhorEnvio1Click(Sender: TObject);
begin
  FormConsultasMelhorEnvio := TConsultasMelhorEnvio.Create(Self);
  try
    FormConsultasMelhorEnvio.ShowModal;
  finally
    FormConsultasMelhorEnvio.Free; // Libera a memória usada
  end;
end;

procedure TFormPrincipal.Azul1Click(Sender: TObject);
begin
  FormConsultaOcorrenciaAzul := TConsultaOcorrenciaAzul.Create(Self);
  try
    FormConsultaOcorrenciaAzul.ShowModal;
  finally
    FormConsultaOcorrenciaAzul.Free; // Libera a memória usada
  end;
end;

//procedure TFormPrincipal.Openlog3Click(Sender: TObject);
//begin
//  FormCotacaoOpenlogEngloba := TCotacaoOpenlogEngloba.Create(Self);
//  try
//    FormCotacaoOpenlogEngloba.ShowModal;
//  finally
//    FormCotacaoOpenlogEngloba.Free; // Libera a memória usada
//  end;
//end;

procedure TFormPrincipal.OpenlogEngloba1Click(Sender: TObject);
begin
  FormConsultaOcorrenciaOpenlog := TConsultaOcorrenciaOpenlog.Create(Self);
  try
    FormConsultaOcorrenciaOpenlog.ShowModal;
  finally
    FormConsultaOcorrenciaOpenlog.Free; // Libera a memória usada
  end;
end;

procedure TFormPrincipal.OpenlogEngloba2Click(Sender: TObject);
begin
  FormCotacaoOpenlogEngloba := TCotacaoOpenlogEngloba.Create(Self);
  try
    FormCotacaoOpenlogEngloba.ShowModal;
  finally
    FormCotacaoOpenlogEngloba.Free; // Libera a memória usada
  end;
end;

procedure TFormPrincipal.otalXMLxTotalCotao1Click(Sender: TObject);
begin
  FormDeParaXmlCte := TDeParaXmlCte.Create(Self);
  try
    FormDeParaXmlCte.ShowModal;
  finally
    FormDeParaXmlCte.Free; // Libera a memória usada
  end;
end;

procedure TFormPrincipal.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFormPrincipal.SSW2Click(Sender: TObject);
begin
  FormTesteSSW := TTesteSSW.Create(Self);
  try
    FormTesteSSW.ShowModal;
  finally
    FormTesteSSW.Free; // Libera a memória usada
  end;
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
    FormConsultaCredencialAzul.Free; // Libera a memória usada
  end;
end;

end.
