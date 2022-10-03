program WKServer;
{$APPTYPE GUI}

{$R *.dres}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uMain in 'uMain.pas' {Main},
  uControllerPessoa in 'uControllerPessoa.pas' {ControllerPessoa: TDSServerModule},
  uServerContainer in 'uServerContainer.pas' {ServerContainer: TDataModule},
  uDM in 'uDM.pas' {WebModule1: TWebModule},
  uPessoa in '..\Classes\uPessoa.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
