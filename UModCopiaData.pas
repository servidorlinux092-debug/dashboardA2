unit UModCopiaData;

interface

uses
  System.SysUtils, System.Classes, System.IOUtils, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Dialogs;

type
  TModCopiaData = class
  private
    FPathExe: string;
    FPathTmp: string;
    FPathDataOrigen: string;
    FTablas: TStringList;
    procedure InicializarRutasYTablas;
  public
    constructor Create;
    destructor Destroy; override;
    function ProcesarCopias(ProgressBar: TProgressBar; LabelEstado: TLabel): Boolean;
  end;

implementation

{ TModCopiaData }

constructor TModCopiaData.Create;
begin
  inherited Create;
  FTablas := TStringList.Create;
  InicializarRutasYTablas;
end;

destructor TModCopiaData.Destroy;
begin
  FTablas.Free;
  inherited;
end;

procedure TModCopiaData.InicializarRutasYTablas;
begin
  // Calcula la ruta donde corre el .exe de forma portátil
  FPathExe := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));

  // Ruta destino local: \tmpkpis\
  FPathTmp := FPathExe + 'tmpkpis' + PathDelim;

  // Ruta origen: \Data\ al lado del ejecutable
  FPathDataOrigen := FPathExe + 'Data' + PathDelim;

  // Las 6 tablas esenciales de a2 Softway
  FTablas.Add('sdetalleventa');
  FTablas.Add('soperacioninv');
  FTablas.Add('sinventario');
  FTablas.Add('sclientes');
  FTablas.Add('scategoria');
  FTablas.Add('svendedores');
  FTablas.Add('szonas');
end;

function TModCopiaData.ProcesarCopias(ProgressBar: TProgressBar; LabelEstado: TLabel): Boolean;
var
  I, J: Integer;
  TablaBase, ArchivoOrigen, ArchivoDestino: string;
  Extensiones: array[0..2] of string;
  TotalArchivos, ArchivosCopiados: Integer;
  ArchivosOmitidos: Integer;
begin
  Result := False;
  Extensiones[0] := '.dat';
  Extensiones[1] := '.idx';
  Extensiones[2] := '.blb';

  TotalArchivos := FTablas.Count * 3; // 18 archivos en total
  ArchivosCopiados := 0;
  ArchivosOmitidos := 0;

  // TEST 1: Verificar si la carpeta de origen 'Data' existe físicamente
  if not TDirectory.Exists(FPathDataOrigen) then
  begin
    ShowMessage('TEST DE RUTA FALLIDO:'#13#10 +
                'No se encontraron datos para trabajar: ' + FPathDataOrigen + #13#10 +
                'Por favor, asegúrese de correr la version correcta del ejecutable.');
    Exit; // Aborta el proceso de inmediato
  end;

  // Configuración de la barra de progreso
  if Assigned(ProgressBar) then
  begin
    ProgressBar.Min := 0;
    ProgressBar.Max := TotalArchivos;
    ProgressBar.Position := 0;
  end;

  try
    // Asegurar la existencia de la carpeta de destino tmpkpis
    if not TDirectory.Exists(FPathTmp) then
    begin
      if Assigned(LabelEstado) then LabelEstado.Caption := 'Creando directorio tmpkpis...';
      TDirectory.CreateDirectory(FPathTmp);
    end;

    // Bucle de copiado de archivos
    for I := 0 to FTablas.Count - 1 do
    begin
      TablaBase := FTablas[I];
      for J := 0 to 2 do
      begin
        ArchivoOrigen  := FPathDataOrigen + TablaBase + Extensiones[J];
        ArchivoDestino := FPathTmp + TablaBase + Extensiones[J];
        Inc(ArchivosCopiados);

        if Assigned(LabelEstado) then
        begin
          LabelEstado.Caption := Format('Sincronizando: %s%s', [TablaBase, Extensiones[J]]);
          LabelEstado.Refresh;
        end;

        // TEST 2: Verificar si el archivo individual existe antes de intentar copiarlo
        if TFile.Exists(ArchivoOrigen) then
        begin
          TFile.Copy(ArchivoOrigen, ArchivoDestino, True);
        end
        else
        begin
          Inc(ArchivosOmitidos);
          // Nota: Si falta un .dat o .idx es grave. Si falta un .blb en a2 puede ser normal
          // si la tabla nunca ha guardado campos largos de texto.
        end;

        if Assigned(ProgressBar) then
        begin
          ProgressBar.Position := ArchivosCopiados;
          ProgressBar.Refresh;
        end;

        // Retardo controlado para que el ojo humano y Wine puedan ver la animación en el Splash Screen
        // (Ajusta este número de milisegundos si quieres que vaya más rápido o lento en el test)
        Sleep(80);
        System.Classes.CheckSynchronize(1);
      end;
    end;

    // TEST 3: Mensaje de éxito detallado tras concluir el bucle
    ShowMessage('EL DASHBOARD INTELIGENTE ESTÁ LISTO PARA COMENZAR:'#13#10 +
                'Carpeta "tmpkpis" actualizada correctamente.'#13#10 +
                'TO-F: ' + IntToStr(ArchivosCopiados) + #13#10 +
                'Ausentes/omitidos: ' + IntToStr(ArchivosOmitidos));

    if Assigned(LabelEstado) then LabelEstado.Caption := '¡Sincronización completa!';
    Result := True;

  except
    on E: Exception do
    begin
      ShowMessage('TEST CRÍTICO FALLIDO: Error durante la copia física. ' + E.Message);
      Result := False;
    end;
  end;
end;

end.

