program CotarFrete;

uses
  Vcl.Forms,
  View.Principal in 'View\View.Principal.pas' {FormPrincipal},
  View.ConsultaCnpj in 'View\View.ConsultaCnpj.pas' {ConsultaCnpj},
  View.ConsultasMelhorEnvio in 'View\View.ConsultasMelhorEnvio.pas' {ConsultasMelhorEnvio},
  View.ConsultaCredencialAzul in 'View\View.ConsultaCredencialAzul.pas' {ConsultaCredencialAzul},
  View.ConsultaServicosKangu in 'View\View.ConsultaServicosKangu.pas' {ConsultaServicosKangu},
  View.CalculoPortalTransportes in 'View\View.CalculoPortalTransportes.pas' {CalculoPortalTransportes},
  View.ConsultasServicosFlixLog in 'View\View.ConsultasServicosFlixLog.pas' {ConsultasServicosFlixLog},
  View.TesteSSW in 'View\View.TesteSSW.pas' {TesteSSW},
  View.GerarTokenJWT in 'View\View.GerarTokenJWT.pas' {GerarTokenJWT},
  View.DeParaXmlCte in 'View\View.DeParaXmlCte.pas' {DeParaXmlCte},
  View.ConsultaOcorrenciaAzul in 'View\View.ConsultaOcorrenciaAzul.pas' {ConsultaOcorrenciaAzul},
  View.ConsultaOcorrenciaBraspress in 'View\View.ConsultaOcorrenciaBraspress.pas' {ConsultaOcorrenciaBraspress},
  View.ConsultaOcorrenciaDaytona in 'View\View.ConsultaOcorrenciaDaytona.pas' {ConsultaOcorrenciaDaytona},
  View.AutenticarCorreios in 'View\View.AutenticarCorreios.pas' {AutenticarCorreios},
  View.ConsultaOcorrenciaBuslog in 'View\View.ConsultaOcorrenciaBuslog.pas' {ConsultaOcorrenciaBuslog},
  View.ConsultaOcorrenciaJadlog in 'View\View.ConsultaOcorrenciaJadlog.pas' {FormConsultaOcorrenciaJadlog},
  View.CotacaoJadlog in 'View\View.CotacaoJadlog.pas' {CotacaoJadlog};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
