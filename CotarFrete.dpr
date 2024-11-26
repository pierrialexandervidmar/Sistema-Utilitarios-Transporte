program CotarFrete;

uses
  Vcl.Forms,
  View.Principal in 'Src\View\View.Principal.pas' {FormPrincipal},
  View.ConsultaCnpj in 'Src\View\View.ConsultaCnpj.pas' {ConsultaCnpj},
  View.ConsultasMelhorEnvio in 'Src\View\View.ConsultasMelhorEnvio.pas' {ConsultasMelhorEnvio},
  View.ConsultaCredencialAzul in 'Src\View\View.ConsultaCredencialAzul.pas' {ConsultaCredencialAzul},
  View.ConsultaServicosKangu in 'Src\View\View.ConsultaServicosKangu.pas' {ConsultaServicosKangu},
  View.CalculoPortalTransportes in 'Src\View\View.CalculoPortalTransportes.pas' {CalculoPortalTransportes},
  View.ConsultasServicosFlixLog in 'Src\View\View.ConsultasServicosFlixLog.pas' {ConsultasServicosFlixLog},
  View.TesteSSW in 'Src\View\View.TesteSSW.pas' {TesteSSW},
  View.GerarTokenJWT in 'Src\View\View.GerarTokenJWT.pas' {GerarTokenJWT},
  View.DeParaXmlCte in 'Src\View\View.DeParaXmlCte.pas' {DeParaXmlCte},
  View.ConsultaOcorrenciaAzul in 'Src\View\View.ConsultaOcorrenciaAzul.pas' {ConsultaOcorrenciaAzul},
  View.ConsultaOcorrenciaBraspress in 'Src\View\View.ConsultaOcorrenciaBraspress.pas' {ConsultaOcorrenciaBraspress},
  View.ConsultaOcorrenciaDaytona in 'Src\View\View.ConsultaOcorrenciaDaytona.pas' {ConsultaOcorrenciaDaytona},
  View.AutenticarCorreios in 'Src\View\View.AutenticarCorreios.pas' {AutenticarCorreios},
  View.ConsultaOcorrenciaBuslog in 'Src\View\View.ConsultaOcorrenciaBuslog.pas' {ConsultaOcorrenciaBuslog},
  View.ConsultaOcorrenciaJadlog in 'Src\View\View.ConsultaOcorrenciaJadlog.pas' {FormConsultaOcorrenciaJadlog},
  View.CotacaoJadlog in 'Src\View\View.CotacaoJadlog.pas' {CotacaoJadlog},
  View.ConsultaOcorrenciaOpenlog in 'Src\View\View.ConsultaOcorrenciaOpenlog.pas' {ConsultaOcorrenciaOpenlog},
  View.GeradorTwig in 'Src\View\View.GeradorTwig.pas' {GeradorTwig},
  View.CotacaoOpenlogEngloba in 'Src\View\View.CotacaoOpenlogEngloba.pas' {CotacaoOpenlogEngloba},
  View.ConsultaOcorrenciaCarriers in 'Src\View\View.ConsultaOcorrenciaCarriers.pas' {ConsultaOcorrenciaCarriers},
  View.ConsultaOcorrenciaSSW in 'Src\View\View.ConsultaOcorrenciaSSW.pas' {ConsultaOcorrenciaSSW},
  View.ConsultaOcorrenciaTotalExpress in 'Src\View\View.ConsultaOcorrenciaTotalExpress.pas' {ConsultaOcorrenciaTotalExpress},
  View.AutenticarTotalExpress in 'Src\View\View.AutenticarTotalExpress.pas' {TesteAutenticacaoTotalExpress},
  View.CotacaoTotalExpress in 'Src\View\View.CotacaoTotalExpress.pas' {CotacaoTotalExpress};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
