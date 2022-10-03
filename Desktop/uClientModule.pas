unit uClientModule;

interface

uses
  System.SysUtils, System.Classes, uClientClasses, Datasnap.DSClientRest;

type
  TClientModule = class(TDataModule)
    DSRestConnection1: TDSRestConnection;
  private
    FInstanceOwner: Boolean;
    FControllerPessoaClient: TControllerPessoaClient;
    function GetControllerPessoaClient: TControllerPessoaClient;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property ControllerPessoaClient: TControllerPessoaClient read GetControllerPessoaClient write FControllerPessoaClient;

end;

var
  ClientModule: TClientModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

constructor TClientModule.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

destructor TClientModule.Destroy;
begin
  FControllerPessoaClient.Free;
  inherited;
end;

function TClientModule.GetControllerPessoaClient: TControllerPessoaClient;
begin
  if FControllerPessoaClient = nil then
    FControllerPessoaClient:= TControllerPessoaClient.Create(DSRestConnection1, FInstanceOwner);
  Result := FControllerPessoaClient;
end;

end.
