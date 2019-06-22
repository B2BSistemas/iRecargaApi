object frmRecarga: TfrmRecarga
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'API iRecarga'
  ClientHeight = 282
  ClientWidth = 581
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblDDD: TLabel
    Left = 8
    Top = 39
    Width = 64
    Height = 13
    Caption = 'Digite o DDD:'
  end
  object lblNumero: TLabel
    Left = 96
    Top = 40
    Width = 121
    Height = 13
    Caption = 'Diugite o N'#176' do Telefone:'
  end
  object lblOperadora: TLabel
    Left = 271
    Top = 39
    Width = 104
    Height = 13
    Caption = 'Escolha a Operadora:'
  end
  object lblVlrCredito: TLabel
    Left = 433
    Top = 39
    Width = 130
    Height = 13
    Caption = 'Escolha o Valor da Recarga'
  end
  object mmResultado: TMemo
    Left = 8
    Top = 85
    Width = 555
    Height = 178
    TabOrder = 0
  end
  object Button2: TButton
    Left = 8
    Top = 8
    Width = 105
    Height = 25
    Caption = 'Lista Operadoeras'
    TabOrder = 1
    OnClick = Button2Click
  end
  object edtDDD: TEdit
    Left = 8
    Top = 58
    Width = 81
    Height = 21
    TabOrder = 2
  end
  object Button3: TButton
    Left = 271
    Top = 8
    Width = 156
    Height = 25
    Caption = 'Lista o Valor Disponivel'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 433
    Top = 8
    Width = 130
    Height = 25
    Caption = 'Confirmar Recarga'
    TabOrder = 4
    OnClick = Button4Click
  end
  object edtNum: TEdit
    Left = 95
    Top = 58
    Width = 170
    Height = 21
    TabOrder = 5
  end
  object cbbOperadora: TComboBox
    Left = 271
    Top = 58
    Width = 156
    Height = 21
    TabOrder = 6
  end
  object cbbVlr: TComboBox
    Left = 433
    Top = 58
    Width = 130
    Height = 21
    TabOrder = 7
  end
  object HTTP: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 248
    Top = 200
  end
end
