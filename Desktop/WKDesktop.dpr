program WKDesktop;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {Main},
  uDMPessoa in 'uDMPessoa.pas' {DMPessoa: TDataModule},
  uClientModule in 'uClientModule.pas' {ClientModule: TDataModule},
  uPessoaCad in 'uPessoaCad.pas' {PessoaCad},
  uPessoaCadM in 'uPessoaCadM.pas' {PessoaCadM},
  uPessoaCadD in 'uPessoaCadD.pas' {PessoaCadD},
  uPessoa in '..\Classes\uPessoa.pas',
  uClientClasses in 'uClientClasses.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TDMPessoa, DMPessoa);
  Application.CreateForm(TClientModule, ClientModule);
  Application.CreateForm(TPessoaCad, PessoaCad);
  Application.CreateForm(TPessoaCadM, PessoaCadM);
  Application.CreateForm(TPessoaCadD, PessoaCadD);
  Application.Run;
end.
