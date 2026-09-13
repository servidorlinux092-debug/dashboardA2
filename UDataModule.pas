unit UDataModule;

interface

uses
  System.SysUtils, System.Classes, dbisamcn, dbisamtb, Data.DB, Vcl.Dialogs;

type
  TDM = class(TDataModule)
    SessionA2: TDBISAMSession;
    DatabaseA2: TDBISAMDatabase;
    QryAnalitycs: TDBISAMQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FPathTmp: string;
  public
    procedure ConectarBaseDatosEspejo;
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  // Generar un nombre de sesión único para evitar conflictos bajo Wine
  SessionA2.SessionName := 'SessionKPI_' + FormatDateTime('hhmmss', Now);
  DatabaseA2.SessionName := SessionA2.SessionName;
  DatabaseA2.DatabaseName := 'KpiData';
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  // Cerrar todo de forma segura al destruir el programa
  DatabaseA2.Connected := False;
  SessionA2.Active := False;
end;

procedure TDM.ConectarBaseDatosEspejo;
begin
  try
    // Calcular de forma portátil la ruta hacia \tmpkpis\
    FPathTmp := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'tmpkpis' + PathDelim;

    // Apuntar el componente a la carpeta espejo que acabamos de copiar
    DatabaseA2.Directory := FPathTmp;
    DatabaseA2.Connected := True;

  except
    on E: Exception do
      ShowMessage('Error crítico al conectar el motor analítico: ' + E.Message);
  end;
end;

end.

