unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList, Vcl.Menus;

type
  TMain = class(TForm)
    MainMenu1: TMainMenu;
    ActionList1: TActionList;
    acPessoas: TAction;
    acPessoas1: TMenuItem;
    procedure acPessoasExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

uses
  uPessoaCad;

{$R *.dfm}

procedure TMain.acPessoasExecute(Sender: TObject);
begin
  PessoaCad.ShowModal;
end;

end.



