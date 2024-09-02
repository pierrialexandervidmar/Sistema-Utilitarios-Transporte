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
  View.TesteSSW in 'View\View.TesteSSW.pas' {TesteSSW};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
