program LocalizationParser;

uses
  Forms,
  LocaleParser in 'LocaleParser.pas' {Form1},
  Declare in 'Declare.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Android Locale Parser';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
