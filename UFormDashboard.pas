unit UFormDashboard;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.CheckLst,
  UDataModule,  // Enlace a tu DataModule
  dbisamtb, VclTee.TeeGDIPlus, VCLTee.Series, VCLTee.TeEngine, VCLTee.TeeProcs,
  VCLTee.Chart;     // Librería nativa para componentes TDBISAMTable

type
  TForm1 = class(TForm)
    PnlFiltros: TPanel;
    dtpDesde: TDateTimePicker;
    Label1: TLabel;
    dtpHasta: TDateTimePicker;
    Label2: TLabel;
    clbZonas: TCheckListBox;
    clbVendedores: TCheckListBox;
    clbCategorias: TCheckListBox; // <-- RE-INCORPORADO: Soluciona los errores del bloque 3
    BtnFiltrar: TButton;
    BtnVersionPro: TButton;
    BtnSalir: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    btntodozna: TButton;
    btnningunzna: TButton;
    btntodovnd: TButton;
    btnningunvnd: TButton;
    btntododpto: TButton;
    btnningundpto: TButton;
    PnlMetricas: TPanel;
    PnlTotalFacturas: TPanel;
    PnlTotalCajas: TPanel;
    PnlTotalClientes: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblCifraFacturas: TLabel;
    lblCifraCajas: TLabel;
    lblCifraClientes: TLabel;
    pnlGraficos: TPanel;
    pnlInfo: TPanel;
    chtVendedores: TChart;
    Series1: THorizBarSeries;
    chtLineas: TChart;
    Series2: TPieSeries; // Etiqueta para Líneas
    procedure BtnSalirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btntodoznaClick(Sender: TObject);
    procedure btnningunznaClick(Sender: TObject);
    procedure btntodovndClick(Sender: TObject);
    procedure btnningunvndClick(Sender: TObject);
    procedure btntododptoClick(Sender: TObject);
    procedure btnningundptoClick(Sender: TObject);
    procedure BtnFiltrarClick(Sender: TObject);
  private
    { Private declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BtnSalirClick(Sender: TObject);
begin
  Application.Terminate;
end;
// ==========================================
// EVENTOS PARA BOTONES DE ZONAS
// ==========================================

procedure TForm1.btntodoznaClick(Sender: TObject);
var I: Integer;

begin
  for I := 0 to clbZonas.Items.Count - 1 do
    clbZonas.Checked[I] := True;
end;

procedure TForm1.btnningunznaClick(Sender: TObject);
var I: Integer;
begin
  for I := 0 to clbZonas.Items.Count - 1 do
    clbZonas.Checked[I] := False;
end;

// ==========================================
// EVENTOS PARA BOTONES DE VENDEDORES
// ==========================================

procedure TForm1.btntodovndClick(Sender: TObject);
var I: Integer;
begin
  for I := 0 to clbVendedores.Items.Count - 1 do
    clbVendedores.Checked[I] := True;
end;

procedure TForm1.btnningunvndClick(Sender: TObject);
var I: Integer;

begin
  for I := 0 to clbVendedores.Items.Count - 1 do
    clbVendedores.Checked[I] := False;
end;

// ==========================================
// EVENTOS PARA BOTONES DE LÍNEAS / DPTO
// ==========================================
procedure TForm1.btntododptoClick(Sender: TObject);
var I: Integer;

begin
  for I := 0 to clbCategorias.Items.Count - 1 do
    clbCategorias.Checked[I] := True;
end;

procedure TForm1.BtnFiltrarClick(Sender: TObject);
var
  FechaIn, FechaFin: string;
begin
  // 1. CONVERTIR LAS FECHAS AL FORMATO REQUERIDO POR DBISAM (AAAA-MM-DD)
  FechaIn  := FormatDateTime('yyyy-mm-dd', dtpDesde.Date);
  FechaFin := FormatDateTime('yyyy-mm-dd', dtpHasta.Date);

  try
    DM.QryAnalitycs.Active := False;
    DM.QryAnalitycs.SQL.Clear;

    // SQL DE PRECISIÓN PARA TARJETAS NUMÉRICAS EN CANTIDADES:
    // - COUNT(DISTINCT...) cuenta solo las facturas únicas (tipo 11), ignorando las devoluciones en el conteo de emisión.
    // - SUM(CASE...) hace la magia: si es Tipo 11 (Factura) suma la cantidad, si es Tipo 12 (Devolución) la multiplica por -1 para que RESTE.
    DM.QryAnalitycs.SQL.Add('SELECT ');
    DM.QryAnalitycs.SQL.Add('  COUNT(DISTINCT CASE WHEN O.FTI_TIPO = 11 THEN O.FTI_AUTOINCREMENT END) AS TotalFacturas, ');
    DM.QryAnalitycs.SQL.Add('  SUM(CASE WHEN O.FTI_TIPO = 11 THEN D.FDI_CANTIDAD WHEN O.FTI_TIPO = 12 THEN (D.FDI_CANTIDAD * -1) ELSE 0 END) AS TotalCajas, ');
    DM.QryAnalitycs.SQL.Add('  COUNT(DISTINCT O.FTI_RIFCLIENTE) AS ClientesActivados '); // Cuenta RIFs únicos que compraron en el periodo
    DM.QryAnalitycs.SQL.Add('FROM sdetalleventa D ');
    DM.QryAnalitycs.SQL.Add('INNER JOIN soperacioninv O ON D.FDI_AUTOINCREMENT = O.FTI_AUTOINCREMENT ');

    // Filtramos por el rango de fechas y limitamos estrictamente a los tipos 11 (Facturas) y 12 (Devoluciones)
    DM.QryAnalitycs.SQL.Add('WHERE O.FTI_FECHAEMISION BETWEEN ' + QuotedStr(FechaIn) + ' AND ' + QuotedStr(FechaFin));
    DM.QryAnalitycs.SQL.Add('AND O.FTI_TIPO IN (11, 12) ');

    // Ejecutamos la consulta analítica en las tablas espejo
    DM.QryAnalitycs.Active := True;

    // 2. ASIGNAR LAS CIFRAS PROCESADAS A TUS TARJETAS VISUALES
    if not DM.QryAnalitycs.IsEmpty then
    begin
      lblCifraFacturas.Caption := FormatFloat('#,##0', DM.QryAnalitycs.FieldByName('TotalFacturas').AsInteger);
      lblCifraCajas.Caption    := FormatFloat('#,##0', DM.QryAnalitycs.FieldByName('TotalCajas').AsFloat);
      lblCifraClientes.Caption := FormatFloat('#,##0', DM.QryAnalitycs.FieldByName('ClientesActivados').AsInteger);
    end
    else
    begin
      // Si no hay datos en ese rango, inicializamos en cero por seguridad
      lblCifraFacturas.Caption := '0';
      lblCifraCajas.Caption    := '0';
      lblCifraClientes.Caption := '0';
    end;

    // Mensaje de estatus a pie de página (pnlInfo)
    pnlInfo.Caption := ' [Métricas] Totales numéricos calculados con éxito. Periodo: ' + FechaIn + ' al ' + FechaFin;

  except
    on E: Exception do
    begin
      pnlInfo.Caption := ' Error en cálculo de métricas: ' + E.Message;
      ShowMessage('Error procesando las cifras del Dashboard: ' + E.Message);
    end;
  end;
end;


procedure TForm1.btnningundptoClick(Sender: TObject);
var I: Integer;

begin
  for I := 0 to clbCategorias.Items.Count - 1 do
    clbCategorias.Checked[I] := False;

end;

procedure TForm1.FormShow(Sender: TObject);
var
  TablaTmp: TDBISAMTable;
  I: Integer; // Declaramos la variable para los bucles de marcado
begin
  TablaTmp := TDBISAMTable.Create(nil);
  try
    TablaTmp.SessionName := DM.SessionA2.SessionName;
    TablaTmp.DatabaseName := DM.DatabaseA2.DatabaseName;

    // 1. CARGAR LAS ZONAS
    clbZonas.Items.BeginUpdate;
    try
      clbZonas.Items.Clear;
      TablaTmp.TableName := 'szonas';
      TablaTmp.Active := True;
      TablaTmp.First;
      while not TablaTmp.Eof do
      begin
        if TablaTmp.FindField('FZ_DESCRIPCION') <> nil then
          clbZonas.Items.Add(TablaTmp.FieldByName('FZ_DESCRIPCION').AsString);
        TablaTmp.Next;
      end;
      TablaTmp.Active := False;
    finally
      clbZonas.Items.EndUpdate;
    end;

    // 2. CARGAR LOS VENDEDORES ACTIVOS
    clbVendedores.Items.BeginUpdate;
    try
      clbVendedores.Items.Clear;
      TablaTmp.TableName := 'svendedores';
      TablaTmp.Active := True;
      TablaTmp.First;
      while not TablaTmp.Eof do
      begin
        if (TablaTmp.FindField('FV_DESCRIPCION') <> nil) and (TablaTmp.FindField('FV_STATUS') <> nil) then
        begin
          if TablaTmp.FieldByName('FV_STATUS').AsBoolean <> False then
            clbVendedores.Items.Add(TablaTmp.FieldByName('FV_DESCRIPCION').AsString);
        end;
        TablaTmp.Next;
      end;
      TablaTmp.Active := False;
    finally
      clbVendedores.Items.EndUpdate;
    end;

    // 3. CARGAR LAS LÍNEAS / CATEGORÍAS ACTIVAS
    clbCategorias.Items.BeginUpdate;
    try
      clbCategorias.Items.Clear;
      TablaTmp.TableName := 'scategoria';
      TablaTmp.Active := True;
      TablaTmp.First;
      while not TablaTmp.Eof do
      begin
        if (TablaTmp.FindField('FD_DESCRIPCION') <> nil) and (TablaTmp.FindField('FD_STATUS') <> nil) then
        begin
          if TablaTmp.FieldByName('FD_STATUS').AsBoolean <> False then
            clbCategorias.Items.Add(TablaTmp.FieldByName('FD_DESCRIPCION').AsString);
        end;
        TablaTmp.Next;
      end;
      TablaTmp.Active := False;
    finally
      clbCategorias.Items.EndUpdate;
    end;

    // ============================================================
    // TU ESTRATEGIA: MARCAR ABSOLUTAMENTE TODO POR DEFECTO AL INICIAR
    // ============================================================
    for I := 0 to clbZonas.Items.Count - 1 do
      clbZonas.Checked[I] := True;

    for I := 0 to clbVendedores.Items.Count - 1 do
      clbVendedores.Checked[I] := True;

    for I := 0 to clbCategorias.Items.Count - 1 do
      clbCategorias.Checked[I] := True;

  finally
    TablaTmp.Free;
  end;
end;

end.


