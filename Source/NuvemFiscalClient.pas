unit NuvemFiscalClient;

interface

uses
  System.SysUtils, 
  OpenApiRest, 
  NuvemFiscalJson, 
  NuvemFiscalDtos;

type
  TRestService = class;
  TCepService = class;
  TCnpjService = class;
  TCteService = class;
  TEmpresaService = class;
  TMdfeService = class;
  TNfceService = class;
  TNfeService = class;
  TNfseService = class;
  TNuvemFiscalConfig = class;
  TNuvemFiscalClient = class;
  
  TRestService = class(TCustomRestService)
  protected
    function CreateConverter: TJsonConverter;
    function Converter: TJsonConverter;
  end;
  
  ICepService = interface(IInvokable)
    ['{F5350711-87FF-4AE2-852C-1EB18BD1CEA5}']
    /// <param name="Cep">
    /// CEP sem máscara.
    /// </param>
    /// <summary>
    /// Consultar endereço através do CEP
    /// </summary>
    function ConsultarCep(Cep: string): TCepEndereco;
  end;
  
  TCepService = class(TRestService, ICepService)
  public
    /// <param name="Cep">
    /// CEP sem máscara.
    /// </param>
    function ConsultarCep(Cep: string): TCepEndereco;
  end;
  
  ICnpjService = interface(IInvokable)
    ['{8E151A0C-46A6-4752-A292-DBE060A33E46}']
    /// <param name="Cnpj">
    /// CNPJ sem máscara.
    /// </param>
    /// <summary>
    /// Consultar dados do CNPJ
    /// </summary>
    function ConsultarCnpj(Cnpj: string): TCnpjEmpresa;
  end;
  
  TCnpjService = class(TRestService, ICnpjService)
  public
    /// <param name="Cnpj">
    /// CNPJ sem máscara.
    /// </param>
    function ConsultarCnpj(Cnpj: string): TCnpjEmpresa;
  end;
  
  /// <summary>
  /// Conhecimento de Transporte Eletrônico.
  /// </summary>
  ICteService = interface(IInvokable)
    ['{B7F0519C-F96C-4AA1-B44C-2231911D7F1D}']
    /// <summary>
    /// Emitir CT-e
    /// </summary>
    function EmitirCte(Body: TCtePedidoEmissao): TDfe;
    /// <param name="Id">
    /// Identificador único do evento.
    /// </param>
    /// <summary>
    /// Consultar evento
    /// </summary>
    function ConsultarEventoCte(Id: string): TDfeEvento;
    /// <param name="Id">
    /// Identificador único do evento.
    /// </param>
    /// <summary>
    /// Baixar XML do evento
    /// </summary>
    function BaixarXmlEventoCte(Id: string): TBytes;
    /// <summary>
    /// Inutilizar uma sequência de numeração de CT-e
    /// </summary>
    function InutilizarCte(Body: TDfePedidoInutilizacao): TDfeInutilizacao;
    /// <param name="Id">
    /// Identificador único do evento.
    /// </param>
    /// <summary>
    /// Consultar a inutilização de sequência de numeração
    /// </summary>
    function ConsultarInutilizacaoCte(Id: string): TDfeInutilizacao;
    /// <param name="Id">
    /// Identificador único do evento.
    /// </param>
    /// <summary>
    /// Baixar XML da inutilização
    /// </summary>
    function BaixarXmlInutilizacaoCte(Id: string): TBytes;
    /// <summary>
    /// Emitir lote de CT-e
    /// </summary>
    function EmitirLoteCte(Body: TCtePedidoEmissaoLote): TDfeLote;
    /// <param name="Id">
    /// Identificador único do lote.
    /// </param>
    /// <summary>
    /// Consultar lote de CT-e
    /// </summary>
    function ConsultarLoteCte(Id: string): TDfeLote;
    /// <param name="CpfCnpj">
    /// CPF/CNPJ do emitente.
    /// Utilize o valor sem máscara.
    /// </param>
    /// <summary>
    /// Consulta do Status do Serviço na SEFAZ Autorizadora
    /// </summary>
    /// <remarks>
    /// Consulta do status do serviço prestado pelo Portal da Secretaria de Fazenda Estadual.
    /// 
    /// A Nuvem Fiscal mantém a última consulta em cache por 5 minutos, evitando sobrecarregar desnecessariamente os servidores da SEFAZ (conforme orientação do MOC - versão 3.0.0a, item 4.6.3). Dessa forma, você poderá chamar esse endpoint quantas vezes quiser, sem preocupar-se em ter o seu CNPJ bloqueado por consumo indevido (Rejeição 656).
    /// </remarks>
    function ConsultarStatusSefazCte(CpfCnpj: string): TDfeVisaoGeralSefazStatus;
    /// <param name="Id">
    /// Identificador único do CT-e.
    /// </param>
    /// <summary>
    /// Consultar CT-e
    /// </summary>
    function ConsultarCte(Id: string): TDfe;
    /// <param name="Id">
    /// Identificador único do CT-e.
    /// </param>
    /// <summary>
    /// Consultar o cancelamento do CT-e
    /// </summary>
    function ConsultarCancelamentoCte(Id: string): TDfeCancelamento;
    /// <param name="Id">
    /// Identificador único do CT-e.
    /// </param>
    /// <summary>
    /// Cancelar um CT-e autorizado
    /// </summary>
    function CancelarCte(Body: TCtePedidoCancelamento; Id: string): TDfeCancelamento;
    /// <param name="Id">
    /// Identificador único do CT-e.
    /// </param>
    /// <summary>
    /// Baixar XML do cancelamento
    /// </summary>
    function BaixarXmlCancelamentoCte(Id: string): TBytes;
    /// <param name="Id">
    /// Identificador único do CT-e.
    /// </param>
    /// <summary>
    /// Consultar a solicitação de correção do CT-e
    /// </summary>
    function ConsultarCartaCorrecaoCte(Id: string): TCteCartaCorrecao;
    /// <param name="Id">
    /// Identificador único do CT-e.
    /// </param>
    /// <summary>
    /// Solicitar correção do CT-e
    /// </summary>
    /// <remarks>
    /// É possível enviar até 20 correções diferentes, sendo que será válido sempre a última correção enviada.
    /// </remarks>
    function CriarCartaCorrecaoCte(Body: TCtePedidoCartaCorrecao; Id: string): TCteCartaCorrecao;
    /// <param name="Id">
    /// Identificador único do CT-e.
    /// </param>
    /// <summary>
    /// Baixar XML da carta de correção
    /// </summary>
    function BaixarXmlCartaCorrecaoCte(Id: string): TBytes;
    /// <param name="Id">
    /// Identificador único do CT-e.
    /// </param>
    /// <summary>
    /// Baixar XML do CT-e processado
    /// </summary>
    function BaixarXmlCte(Id: string): TBytes;
  end;
  
  TCteService = class(TRestService, ICteService)
  public
    function EmitirCte(Body: TCtePedidoEmissao): TDfe;
    /// <param name="Id">
    /// Identificador único do evento.
    /// </param>
    function ConsultarEventoCte(Id: string): TDfeEvento;
    /// <param name="Id">
    /// Identificador único do evento.
    /// </param>
    function BaixarXmlEventoCte(Id: string): TBytes;
    function InutilizarCte(Body: TDfePedidoInutilizacao): TDfeInutilizacao;
    /// <param name="Id">
    /// Identificador único do evento.
    /// </param>
    function ConsultarInutilizacaoCte(Id: string): TDfeInutilizacao;
    /// <param name="Id">
    /// Identificador único do evento.
    /// </param>
    function BaixarXmlInutilizacaoCte(Id: string): TBytes;
    function EmitirLoteCte(Body: TCtePedidoEmissaoLote): TDfeLote;
    /// <param name="Id">
    /// Identificador único do lote.
    /// </param>
    function ConsultarLoteCte(Id: string): TDfeLote;
    /// <param name="CpfCnpj">
    /// CPF/CNPJ do emitente.
    /// Utilize o valor sem máscara.
    /// </param>
    function ConsultarStatusSefazCte(CpfCnpj: string): TDfeVisaoGeralSefazStatus;
    /// <param name="Id">
    /// Identificador único do CT-e.
    /// </param>
    function ConsultarCte(Id: string): TDfe;
    /// <param name="Id">
    /// Identificador único do CT-e.
    /// </param>
    function ConsultarCancelamentoCte(Id: string): TDfeCancelamento;
    /// <param name="Id">
    /// Identificador único do CT-e.
    /// </param>
    function CancelarCte(Body: TCtePedidoCancelamento; Id: string): TDfeCancelamento;
    /// <param name="Id">
    /// Identificador único do CT-e.
    /// </param>
    function BaixarXmlCancelamentoCte(Id: string): TBytes;
    /// <param name="Id">
    /// Identificador único do CT-e.
    /// </param>
    function ConsultarCartaCorrecaoCte(Id: string): TCteCartaCorrecao;
    /// <param name="Id">
    /// Identificador único do CT-e.
    /// </param>
    function CriarCartaCorrecaoCte(Body: TCtePedidoCartaCorrecao; Id: string): TCteCartaCorrecao;
    /// <param name="Id">
    /// Identificador único do CT-e.
    /// </param>
    function BaixarXmlCartaCorrecaoCte(Id: string): TBytes;
    /// <param name="Id">
    /// Identificador único do CT-e.
    /// </param>
    function BaixarXmlCte(Id: string): TBytes;
  end;
  
  /// <summary>
  /// Cadastre e administre todas as empresas vinculadas à sua conta.
  /// </summary>
  IEmpresaService = interface(IInvokable)
    ['{F9F29CFD-FEC1-4997-804F-2BD718558EEE}']
    /// <param name="CpfCnpj">
    /// Filtrar pelo CPF ou CNPJ da empresa.
    /// Utilize o valor sem máscara.
    /// </param>
    /// <summary>
    /// Consultar empresas
    /// </summary>
    /// <remarks>
    /// Retorna a lista das empresas associadas à sua conta. As empresas são retornadas ordenadas pela data da criação, com as mais recentes aparecendo primeiro.
    /// </remarks>
    function ListarEmpresas(Top: Integer; Skip: Integer; CpfCnpj: string): TEmpresaListagem;
    /// <summary>
    /// Cadastrar empresa
    /// </summary>
    /// <remarks>
    /// Cadastre uma nova empresa (emitente ou prestador) à sua conta.
    /// </remarks>
    function CriarEmpresa(Body: TEmpresa): TEmpresa;
    /// <summary>
    /// Consultar empresa
    /// </summary>
    function ConsultarEmpresa(CpfCnpj: string): TEmpresa;
    /// <summary>
    /// Deletar empresa
    /// </summary>
    procedure ExcluirEmpresa(CpfCnpj: string);
    /// <summary>
    /// Alterar empresa
    /// </summary>
    /// <remarks>
    /// Altera o cadastro de uma empresa (emitente/prestador) que esteja associada a sua conta.
    /// Neste método, você pode alterar um único campo específico ou todo o cadastro (campos não informados serão deixados inalterados).
    /// </remarks>
    function AtualizarEmpresa(Body: TEmpresa; CpfCnpj: string): TEmpresa;
    /// <summary>
    /// Consultar certificado
    /// </summary>
    function ConsultarCertificadoEmpresa(CpfCnpj: string): TEmpresaCertificado;
    /// <summary>
    /// Cadastrar certificado
    /// </summary>
    /// <remarks>
    /// Cadastre um certificado digital e vincule a sua empresa, para que possa iniciar a emissão de notas.
    /// * No parâmetro `certificado`, envie o binário do certificado digital (.pfx ou .p12) codificado em **base64**.
    /// </remarks>
    function CadastrarCertificadoEmpresa(Body: TEmpresaPedidoCadastroCertificado; CpfCnpj: string): TEmpresaCertificado;
    /// <summary>
    /// Deletar certificado
    /// </summary>
    procedure ExcluirCertificadoEmpresa(CpfCnpj: string);
    /// <summary>
    /// Upload de certificado
    /// </summary>
    /// <remarks>
    /// Cadastre um certificado digital e vincule a sua empresa, para que possa iniciar a emissão de notas.
    /// * Utilize o `content-type` igual a `multipart/form-data`.
    /// * No parâmetro `file`, envie o binário do arquivo (.pfx ou .p12) do certificado digital.
    /// * No parâmetro `password`, envie a senha do certificado.
    /// </remarks>
    function EnviarCertificadoEmpresa(Input: TBytes; CpfCnpj: string): TEmpresaCertificado;
  end;
  
  TEmpresaService = class(TRestService, IEmpresaService)
  public
    /// <param name="CpfCnpj">
    /// Filtrar pelo CPF ou CNPJ da empresa.
    /// Utilize o valor sem máscara.
    /// </param>
    function ListarEmpresas(Top: Integer; Skip: Integer; CpfCnpj: string): TEmpresaListagem;
    function CriarEmpresa(Body: TEmpresa): TEmpresa;
    function ConsultarEmpresa(CpfCnpj: string): TEmpresa;
    procedure ExcluirEmpresa(CpfCnpj: string);
    function AtualizarEmpresa(Body: TEmpresa; CpfCnpj: string): TEmpresa;
    function ConsultarCertificadoEmpresa(CpfCnpj: string): TEmpresaCertificado;
    function CadastrarCertificadoEmpresa(Body: TEmpresaPedidoCadastroCertificado; CpfCnpj: string): TEmpresaCertificado;
    procedure ExcluirCertificadoEmpresa(CpfCnpj: string);
    function EnviarCertificadoEmpresa(Input: TBytes; CpfCnpj: string): TEmpresaCertificado;
  end;
  
  /// <summary>
  /// Manifesto Eletrônico de Documentos Fiscais.
  /// </summary>
  IMdfeService = interface(IInvokable)
    ['{5E1D08DB-F0BC-4503-AAD9-D4B153FEBAF9}']
    /// <summary>
    /// Emitir MDF-e
    /// </summary>
    function EmitirMdfe(Body: TMdfePedidoEmissao): TDfe;
    /// <param name="Id">
    /// Identificador único do evento.
    /// </param>
    /// <summary>
    /// Consultar evento do MDF-e
    /// </summary>
    function ConsultarEventoMdfe(Id: string): TDfeEvento;
    /// <param name="Id">
    /// Identificador único do evento.
    /// </param>
    /// <summary>
    /// Baixar XML do evento
    /// </summary>
    function BaixarXmlEventoMdfe(Id: string): TBytes;
    /// <summary>
    /// Emitir lote de MDF-e
    /// </summary>
    function EmitirLoteMdfe(Body: TMdfePedidoEmissaoLote): TDfeLote;
    /// <param name="Id">
    /// Identificador único do lote.
    /// </param>
    /// <summary>
    /// Consultar lote de MDF-e
    /// </summary>
    function ConsultarLoteMdfe(Id: string): TDfeLote;
    /// <param name="CpfCnpj">
    /// CPF/CNPJ do emitente.
    /// Utilize o valor sem máscara.
    /// </param>
    /// <summary>
    /// Consulta do Status do Serviço na SEFAZ Autorizadora
    /// </summary>
    /// <remarks>
    /// Consulta do status do serviço prestado pelo Portal da Secretaria de Fazenda Estadual.
    /// 
    /// A Nuvem Fiscal mantém a última consulta em cache por 5 minutos, evitando sobrecarregar desnecessariamente os servidores da SEFAZ (conforme orientação do MOC - versão 3.0.0a, item 4.6.3). Dessa forma, você poderá chamar esse endpoint quantas vezes quiser, sem preocupar-se em ter o seu CNPJ bloqueado por consumo indevido (Rejeição 656).
    /// </remarks>
    function ConsultarStatusSefazMdfe(CpfCnpj: string): TDfeVisaoGeralSefazStatus;
    /// <param name="Id">
    /// Identificador único do MDF-e.
    /// </param>
    /// <summary>
    /// Consultar MDF-e
    /// </summary>
    function ConsultarMdfe(Id: string): TDfe;
    /// <param name="Id">
    /// Identificador único do MDF-e.
    /// </param>
    /// <summary>
    /// Consultar o cancelamento do MDF-e
    /// </summary>
    function ConsultarCancelamentoMdfe(Id: string): TDfeCancelamento;
    /// <param name="Id">
    /// Identificador único do MDF-e.
    /// </param>
    /// <summary>
    /// Cancelar um MDF-e autorizado
    /// </summary>
    function CancelarMdfe(Body: TMdfePedidoCancelamento; Id: string): TDfeCancelamento;
    /// <param name="Id">
    /// Identificador único do MDF-e.
    /// </param>
    /// <summary>
    /// Baixar XML do cancelamento
    /// </summary>
    function BaixarXmlCancelamentoMdfe(Id: string): TBytes;
    /// <param name="Id">
    /// Identificador único do MDF-e.
    /// </param>
    /// <summary>
    /// Consultar encerramento do MDF-e
    /// </summary>
    function ConsultarEncerramentoMdfe(Id: string): TMdfeEncerramento;
    /// <param name="Id">
    /// Identificador único do MDF-e.
    /// </param>
    /// <summary>
    /// Encerrar um MDF-e autorizado
    /// </summary>
    function EncerrarMdfe(Body: TMdfePedidoEncerramento; Id: string): TMdfeEncerramento;
    /// <param name="Id">
    /// Identificador único do MDF-e.
    /// </param>
    /// <summary>
    /// Baixar XML do encerramento
    /// </summary>
    function BaixarXmlEncerramentoMdfe(Id: string): TBytes;
    /// <param name="Id">
    /// Identificador único do MDF-e.
    /// </param>
    /// <summary>
    /// Incluir um condutor em um MDF-e autorizado
    /// </summary>
    function IncluirCondutorMdfe(Body: TMdfePedidoInclusaoCondutor; Id: string): TMdfeInclusaoCondutor;
    /// <param name="Id">
    /// Identificador único do MDF-e.
    /// </param>
    /// <summary>
    /// Incluir um DF-e em um MDF-e autorizado
    /// </summary>
    function IncluirDfeMdfe(Body: TMdfePedidoInclusaoDfe; Id: string): TMdfeInclusaoDfe;
    /// <param name="Id">
    /// Identificador único do Manifesto.
    /// </param>
    /// <summary>
    /// Baixar XML do MDF-e processado
    /// </summary>
    function BaixarXmlMdfe(Id: string): TBytes;
  end;
  
  TMdfeService = class(TRestService, IMdfeService)
  public
    function EmitirMdfe(Body: TMdfePedidoEmissao): TDfe;
    /// <param name="Id">
    /// Identificador único do evento.
    /// </param>
    function ConsultarEventoMdfe(Id: string): TDfeEvento;
    /// <param name="Id">
    /// Identificador único do evento.
    /// </param>
    function BaixarXmlEventoMdfe(Id: string): TBytes;
    function EmitirLoteMdfe(Body: TMdfePedidoEmissaoLote): TDfeLote;
    /// <param name="Id">
    /// Identificador único do lote.
    /// </param>
    function ConsultarLoteMdfe(Id: string): TDfeLote;
    /// <param name="CpfCnpj">
    /// CPF/CNPJ do emitente.
    /// Utilize o valor sem máscara.
    /// </param>
    function ConsultarStatusSefazMdfe(CpfCnpj: string): TDfeVisaoGeralSefazStatus;
    /// <param name="Id">
    /// Identificador único do MDF-e.
    /// </param>
    function ConsultarMdfe(Id: string): TDfe;
    /// <param name="Id">
    /// Identificador único do MDF-e.
    /// </param>
    function ConsultarCancelamentoMdfe(Id: string): TDfeCancelamento;
    /// <param name="Id">
    /// Identificador único do MDF-e.
    /// </param>
    function CancelarMdfe(Body: TMdfePedidoCancelamento; Id: string): TDfeCancelamento;
    /// <param name="Id">
    /// Identificador único do MDF-e.
    /// </param>
    function BaixarXmlCancelamentoMdfe(Id: string): TBytes;
    /// <param name="Id">
    /// Identificador único do MDF-e.
    /// </param>
    function ConsultarEncerramentoMdfe(Id: string): TMdfeEncerramento;
    /// <param name="Id">
    /// Identificador único do MDF-e.
    /// </param>
    function EncerrarMdfe(Body: TMdfePedidoEncerramento; Id: string): TMdfeEncerramento;
    /// <param name="Id">
    /// Identificador único do MDF-e.
    /// </param>
    function BaixarXmlEncerramentoMdfe(Id: string): TBytes;
    /// <param name="Id">
    /// Identificador único do MDF-e.
    /// </param>
    function IncluirCondutorMdfe(Body: TMdfePedidoInclusaoCondutor; Id: string): TMdfeInclusaoCondutor;
    /// <param name="Id">
    /// Identificador único do MDF-e.
    /// </param>
    function IncluirDfeMdfe(Body: TMdfePedidoInclusaoDfe; Id: string): TMdfeInclusaoDfe;
    /// <param name="Id">
    /// Identificador único do Manifesto.
    /// </param>
    function BaixarXmlMdfe(Id: string): TBytes;
  end;
  
  /// <summary>
  /// Nota Fiscal de Consumidor Eletrônica.
  /// </summary>
  INfceService = interface(IInvokable)
    ['{FA91917B-DF86-4161-B005-93D0BD5C4A89}']
    /// <summary>
    /// Emitir NFC-e
    /// </summary>
    function EmitirNfce(Body: TNfePedidoEmissao): TDfe;
    /// <summary>
    /// Inutilizar uma sequência de numeração de NFC-e
    /// </summary>
    function InutilizarNfce(Body: TDfePedidoInutilizacao): TDfeInutilizacao;
    /// <param name="Id">
    /// Identificador único do evento.
    /// </param>
    /// <summary>
    /// Consultar a inutilização de sequência de numeração
    /// </summary>
    function ConsultarInutilizacaoNfce(Id: string): TDfeInutilizacao;
    /// <param name="Id">
    /// Identificador único do evento.
    /// </param>
    /// <summary>
    /// Baixar XML da inutilização
    /// </summary>
    function BaixarXmlInutilizacaoNfce(Id: string): TBytes;
    /// <summary>
    /// Emitir lote de NFC-e
    /// </summary>
    function EmitirLoteNfce(Body: TNfePedidoEmissaoLote): TDfeLote;
    /// <param name="Id">
    /// Identificador único do lote.
    /// </param>
    /// <summary>
    /// Consultar lote de NFC-e
    /// </summary>
    function ConsultarLoteNfce(Id: string): TDfeLote;
    /// <param name="CpfCnpj">
    /// CPF/CNPJ do emitente.
    /// Utilize o valor sem máscara.
    /// </param>
    /// <summary>
    /// Consulta do Status do Serviço na SEFAZ Autorizadora
    /// </summary>
    /// <remarks>
    /// Consulta do status do serviço prestado pelo Portal da Secretaria de Fazenda Estadual.
    /// 
    /// A Nuvem Fiscal mantém a última consulta em cache por 5 minutos, evitando sobrecarregar desnecessariamente os servidores da SEFAZ (conforme orientação do MOC - versão 7.0, item 5.5.3). Dessa forma, você poderá chamar esse endpoint quantas vezes quiser, sem preocupar-se em ter o seu CNPJ bloqueado por consumo indevido (Rejeição 656).
    /// </remarks>
    function ConsultarStatusSefazNfce(CpfCnpj: string): TDfeVisaoGeralSefazStatus;
    /// <param name="Id">
    /// Identificador único da NFC-e.
    /// </param>
    /// <summary>
    /// Consultar NFC-e
    /// </summary>
    function ConsultarNfce(Id: string): TDfe;
    /// <param name="Id">
    /// Identificador único da NFC-e.
    /// </param>
    /// <summary>
    /// Consultar o cancelamento da NFC-e
    /// </summary>
    function ConsultarCancelamentoNfce(Id: string): TDfeCancelamento;
    /// <param name="Id">
    /// Identificador único da NFC-e.
    /// </param>
    /// <summary>
    /// Cancelar uma NFC-e autorizada
    /// </summary>
    function CancelarNfce(Body: TNfePedidoCancelamento; Id: string): TDfeCancelamento;
    /// <param name="Id">
    /// Identificador único da NFC-e.
    /// </param>
    /// <summary>
    /// Baixar XML do cancelamento
    /// </summary>
    function BaixarXmlCancelamentoNfce(Id: string): TBytes;
    /// <param name="Id">
    /// Identificador único da NFC-e.
    /// </param>
    /// <summary>
    /// Baixar PDF do DANFCE
    /// </summary>
    function BaixarPdfNfce(Id: string): TBytes;
    /// <param name="Id">
    /// Identificador único da NFC-e.
    /// </param>
    /// <summary>
    /// Baixar XML da NFC-e processada
    /// </summary>
    function BaixarXmlNfce(Id: string): TBytes;
  end;
  
  TNfceService = class(TRestService, INfceService)
  public
    function EmitirNfce(Body: TNfePedidoEmissao): TDfe;
    function InutilizarNfce(Body: TDfePedidoInutilizacao): TDfeInutilizacao;
    /// <param name="Id">
    /// Identificador único do evento.
    /// </param>
    function ConsultarInutilizacaoNfce(Id: string): TDfeInutilizacao;
    /// <param name="Id">
    /// Identificador único do evento.
    /// </param>
    function BaixarXmlInutilizacaoNfce(Id: string): TBytes;
    function EmitirLoteNfce(Body: TNfePedidoEmissaoLote): TDfeLote;
    /// <param name="Id">
    /// Identificador único do lote.
    /// </param>
    function ConsultarLoteNfce(Id: string): TDfeLote;
    /// <param name="CpfCnpj">
    /// CPF/CNPJ do emitente.
    /// Utilize o valor sem máscara.
    /// </param>
    function ConsultarStatusSefazNfce(CpfCnpj: string): TDfeVisaoGeralSefazStatus;
    /// <param name="Id">
    /// Identificador único da NFC-e.
    /// </param>
    function ConsultarNfce(Id: string): TDfe;
    /// <param name="Id">
    /// Identificador único da NFC-e.
    /// </param>
    function ConsultarCancelamentoNfce(Id: string): TDfeCancelamento;
    /// <param name="Id">
    /// Identificador único da NFC-e.
    /// </param>
    function CancelarNfce(Body: TNfePedidoCancelamento; Id: string): TDfeCancelamento;
    /// <param name="Id">
    /// Identificador único da NFC-e.
    /// </param>
    function BaixarXmlCancelamentoNfce(Id: string): TBytes;
    /// <param name="Id">
    /// Identificador único da NFC-e.
    /// </param>
    function BaixarPdfNfce(Id: string): TBytes;
    /// <param name="Id">
    /// Identificador único da NFC-e.
    /// </param>
    function BaixarXmlNfce(Id: string): TBytes;
  end;
  
  /// <summary>
  /// Nota Fiscal Eletrônica.
  /// </summary>
  INfeService = interface(IInvokable)
    ['{D906B9B9-704D-44DF-856B-3E84AF1B3CD0}']
    /// <summary>
    /// Emitir NF-e
    /// </summary>
    function EmitirNfe(Body: TNfePedidoEmissao): TDfe;
    /// <param name="Id">
    /// Identificador único do evento.
    /// </param>
    /// <summary>
    /// Consultar evento
    /// </summary>
    function ConsultarEventoNfe(Id: string): TDfeEvento;
    /// <param name="Id">
    /// Identificador único do evento.
    /// </param>
    /// <summary>
    /// Baixar XML do evento
    /// </summary>
    function BaixarXmlEventoNfe(Id: string): TBytes;
    /// <summary>
    /// Inutilizar uma sequência de numeração de NF-e
    /// </summary>
    function InutilizarNfe(Body: TDfePedidoInutilizacao): TDfeInutilizacao;
    /// <param name="Id">
    /// Identificador único do evento.
    /// </param>
    /// <summary>
    /// Consultar a inutilização de sequência de numeração
    /// </summary>
    function ConsultarInutilizacaoNfe(Id: string): TDfeInutilizacao;
    /// <param name="Id">
    /// Identificador único do evento.
    /// </param>
    /// <summary>
    /// Baixar XML da inutilização
    /// </summary>
    function BaixarXmlInutilizacaoNfe(Id: string): TBytes;
    /// <summary>
    /// Emitir lote de NF-e
    /// </summary>
    function EmitirLoteNfe(Body: TNfePedidoEmissaoLote): TDfeLote;
    /// <param name="Id">
    /// Identificador único do lote.
    /// </param>
    /// <summary>
    /// Consultar lote de NF-e
    /// </summary>
    function ConsultarLoteNfe(Id: string): TDfeLote;
    /// <param name="CpfCnpj">
    /// CPF/CNPJ do emitente.
    /// Utilize o valor sem máscara.
    /// </param>
    /// <summary>
    /// Consulta do Status do Serviço na SEFAZ Autorizadora
    /// </summary>
    /// <remarks>
    /// Consulta do status do serviço prestado pelo Portal da Secretaria de Fazenda Estadual.
    /// 
    /// A Nuvem Fiscal mantém a última consulta em cache por 5 minutos, evitando sobrecarregar desnecessariamente os servidores da SEFAZ (conforme orientação do MOC - versão 7.0, item 5.5.3). Dessa forma, você poderá chamar esse endpoint quantas vezes quiser, sem preocupar-se em ter o seu CNPJ bloqueado por consumo indevido (Rejeição 656).
    /// </remarks>
    function ConsultarStatusSefazNfe(CpfCnpj: string): TDfeVisaoGeralSefazStatus;
    /// <param name="Id">
    /// Identificador único da NF-e.
    /// </param>
    /// <summary>
    /// Consultar NF-e
    /// </summary>
    function ConsultarNfe(Id: string): TDfe;
    /// <param name="Id">
    /// Identificador único da NF-e.
    /// </param>
    /// <summary>
    /// Consultar o cancelamento da NF-e
    /// </summary>
    function ConsultarCancelamentoNfe(Id: string): TDfeCancelamento;
    /// <param name="Id">
    /// Identificador único da NF-e.
    /// </param>
    /// <summary>
    /// Cancelar uma NF-e autorizada
    /// </summary>
    function CancelarNfe(Body: TNfePedidoCancelamento; Id: string): TDfeCancelamento;
    /// <param name="Id">
    /// Identificador único da NF-e.
    /// </param>
    /// <summary>
    /// Baixar XML do cancelamento
    /// </summary>
    function BaixarXmlCancelamentoNfe(Id: string): TBytes;
    /// <param name="Id">
    /// Identificador único da NF-e.
    /// </param>
    /// <summary>
    /// Consultar a solicitação de correção da NF-e
    /// </summary>
    function ConsultarCartaCorrecaoNfe(Id: string): TDfeCartaCorrecao;
    /// <param name="Id">
    /// Identificador único da NF-e.
    /// </param>
    /// <summary>
    /// Solicitar correção da NF-e
    /// </summary>
    /// <remarks>
    /// É possível enviar até 20 correções diferentes, sendo que será válido sempre a última correção enviada.
    /// </remarks>
    function CriarCartaCorrecaoNfe(Body: TNfePedidoCartaCorrecao; Id: string): TDfeCartaCorrecao;
    /// <param name="Id">
    /// Identificador único da NF-e.
    /// </param>
    /// <summary>
    /// Baixar XML da carta de correção
    /// </summary>
    function BaixarXmlCartaCorrecaoNfe(Id: string): TBytes;
    /// <param name="Id">
    /// Identificador único da NF-e.
    /// </param>
    /// <summary>
    /// Baixar PDF do DANFE
    /// </summary>
    function BaixarPdfNfe(Id: string): TBytes;
    /// <param name="Id">
    /// Identificador único da nota.
    /// </param>
    /// <summary>
    /// Baixar XML da NF-e processada
    /// </summary>
    function BaixarXmlNfe(Id: string): TBytes;
  end;
  
  TNfeService = class(TRestService, INfeService)
  public
    function EmitirNfe(Body: TNfePedidoEmissao): TDfe;
    /// <param name="Id">
    /// Identificador único do evento.
    /// </param>
    function ConsultarEventoNfe(Id: string): TDfeEvento;
    /// <param name="Id">
    /// Identificador único do evento.
    /// </param>
    function BaixarXmlEventoNfe(Id: string): TBytes;
    function InutilizarNfe(Body: TDfePedidoInutilizacao): TDfeInutilizacao;
    /// <param name="Id">
    /// Identificador único do evento.
    /// </param>
    function ConsultarInutilizacaoNfe(Id: string): TDfeInutilizacao;
    /// <param name="Id">
    /// Identificador único do evento.
    /// </param>
    function BaixarXmlInutilizacaoNfe(Id: string): TBytes;
    function EmitirLoteNfe(Body: TNfePedidoEmissaoLote): TDfeLote;
    /// <param name="Id">
    /// Identificador único do lote.
    /// </param>
    function ConsultarLoteNfe(Id: string): TDfeLote;
    /// <param name="CpfCnpj">
    /// CPF/CNPJ do emitente.
    /// Utilize o valor sem máscara.
    /// </param>
    function ConsultarStatusSefazNfe(CpfCnpj: string): TDfeVisaoGeralSefazStatus;
    /// <param name="Id">
    /// Identificador único da NF-e.
    /// </param>
    function ConsultarNfe(Id: string): TDfe;
    /// <param name="Id">
    /// Identificador único da NF-e.
    /// </param>
    function ConsultarCancelamentoNfe(Id: string): TDfeCancelamento;
    /// <param name="Id">
    /// Identificador único da NF-e.
    /// </param>
    function CancelarNfe(Body: TNfePedidoCancelamento; Id: string): TDfeCancelamento;
    /// <param name="Id">
    /// Identificador único da NF-e.
    /// </param>
    function BaixarXmlCancelamentoNfe(Id: string): TBytes;
    /// <param name="Id">
    /// Identificador único da NF-e.
    /// </param>
    function ConsultarCartaCorrecaoNfe(Id: string): TDfeCartaCorrecao;
    /// <param name="Id">
    /// Identificador único da NF-e.
    /// </param>
    function CriarCartaCorrecaoNfe(Body: TNfePedidoCartaCorrecao; Id: string): TDfeCartaCorrecao;
    /// <param name="Id">
    /// Identificador único da NF-e.
    /// </param>
    function BaixarXmlCartaCorrecaoNfe(Id: string): TBytes;
    /// <param name="Id">
    /// Identificador único da NF-e.
    /// </param>
    function BaixarPdfNfe(Id: string): TBytes;
    /// <param name="Id">
    /// Identificador único da nota.
    /// </param>
    function BaixarXmlNfe(Id: string): TBytes;
  end;
  
  INfseService = interface(IInvokable)
    ['{00351D96-6B77-4D0B-88A2-7519492A12B6}']
    /// <param name="CpfCnpj">
    /// Filtrar pelo CPF ou CNPJ do prestador.
    /// Utilize o valor sem máscara.
    /// </param>
    function ListarNfse(Top: Integer; Skip: Integer; CpfCnpj: string; Referencia: string; Ambiente: string): TNfseListagem;
    function EmitirNfse(Body: TNfsePedidoEmissao): TNfse;
    /// <param name="CpfCnpj">
    /// Filtrar pelo CPF ou CNPJ do prestador.
    /// Utilize o valor sem máscara.
    /// </param>
    function ListarLotesNfse(Top: Integer; Skip: Integer; CpfCnpj: string; Referencia: string; Ambiente: string): TRpsLoteListagem;
    function EmitirLoteNfse(Body: TRpsPedidoEmissaoLote): TRpsLote;
    function ConsultarLoteNfse(Id: string): TRpsLote;
    function ConsultarNfse(Id: string): TNfse;
    function ConsultarCancelamentoNfse(Id: string): TNfseCancelamento;
    function CancelarNfse(Id: string): TNfseCancelamento;
    function BaixarXmlNfse(Id: string): TBytes;
  end;
  
  TNfseService = class(TRestService, INfseService)
  public
    /// <param name="CpfCnpj">
    /// Filtrar pelo CPF ou CNPJ do prestador.
    /// Utilize o valor sem máscara.
    /// </param>
    function ListarNfse(Top: Integer; Skip: Integer; CpfCnpj: string; Referencia: string; Ambiente: string): TNfseListagem;
    function EmitirNfse(Body: TNfsePedidoEmissao): TNfse;
    /// <param name="CpfCnpj">
    /// Filtrar pelo CPF ou CNPJ do prestador.
    /// Utilize o valor sem máscara.
    /// </param>
    function ListarLotesNfse(Top: Integer; Skip: Integer; CpfCnpj: string; Referencia: string; Ambiente: string): TRpsLoteListagem;
    function EmitirLoteNfse(Body: TRpsPedidoEmissaoLote): TRpsLote;
    function ConsultarLoteNfse(Id: string): TRpsLote;
    function ConsultarNfse(Id: string): TNfse;
    function ConsultarCancelamentoNfse(Id: string): TNfseCancelamento;
    function CancelarNfse(Id: string): TNfseCancelamento;
    function BaixarXmlNfse(Id: string): TBytes;
  end;
  
  TNuvemFiscalConfig = class(TCustomRestConfig)
  public
    constructor Create;
  end;
  
  INuvemFiscalClient = interface(IRestClient)
    function Cep: ICepService;
    function Cnpj: ICnpjService;
    /// <summary>
    /// Conhecimento de Transporte Eletrônico.
    /// </summary>
    function Cte: ICteService;
    /// <summary>
    /// Cadastre e administre todas as empresas vinculadas à sua conta.
    /// </summary>
    function Empresa: IEmpresaService;
    /// <summary>
    /// Manifesto Eletrônico de Documentos Fiscais.
    /// </summary>
    function Mdfe: IMdfeService;
    /// <summary>
    /// Nota Fiscal de Consumidor Eletrônica.
    /// </summary>
    function Nfce: INfceService;
    /// <summary>
    /// Nota Fiscal Eletrônica.
    /// </summary>
    function Nfe: INfeService;
    function Nfse: INfseService;
  end;
  
  TNuvemFiscalClient = class(TCustomRestClient, INuvemFiscalClient)
  public
    function Cep: ICepService;
    function Cnpj: ICnpjService;
    function Cte: ICteService;
    function Empresa: IEmpresaService;
    function Mdfe: IMdfeService;
    function Nfce: INfceService;
    function Nfe: INfeService;
    function Nfse: INfseService;
    constructor Create;
  end;
  
implementation

{ TRestService }

function TRestService.CreateConverter: TJsonConverter;
begin
  Result := TJsonConverter.Create;
end;

function TRestService.Converter: TJsonConverter;
begin
  Result := TJsonConverter(inherited Converter);
end;

{ TCepService }

function TCepService.ConsultarCep(Cep: string): TCepEndereco;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/cep/{Cep}', 'GET');
  Request.AddUrlParam('Cep', Cep);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TCepEnderecoFromJson(Response.ContentAsString);
end;

{ TCnpjService }

function TCnpjService.ConsultarCnpj(Cnpj: string): TCnpjEmpresa;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/cnpj/{Cnpj}', 'GET');
  Request.AddUrlParam('Cnpj', Cnpj);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TCnpjEmpresaFromJson(Response.ContentAsString);
end;

{ TCteService }

function TCteService.EmitirCte(Body: TCtePedidoEmissao): TDfe;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/cte', 'POST');
  Request.AddBody(Converter.TCtePedidoEmissaoToJson(Body));
  Request.AddHeader('Content-Type', 'application/json');
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeFromJson(Response.ContentAsString);
end;

function TCteService.ConsultarEventoCte(Id: string): TDfeEvento;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/cte/eventos/{id}', 'GET');
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeEventoFromJson(Response.ContentAsString);
end;

function TCteService.BaixarXmlEventoCte(Id: string): TBytes;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/cte/eventos/{id}/xml', 'GET');
  Request.AddUrlParam('id', Id);
  Response := Request.Execute;
  CheckError(Response);
  Result := Response.ContentAsBytes;
end;

function TCteService.InutilizarCte(Body: TDfePedidoInutilizacao): TDfeInutilizacao;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/cte/inutilizacoes', 'POST');
  Request.AddBody(Converter.TDfePedidoInutilizacaoToJson(Body));
  Request.AddHeader('Content-Type', 'application/json');
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeInutilizacaoFromJson(Response.ContentAsString);
end;

function TCteService.ConsultarInutilizacaoCte(Id: string): TDfeInutilizacao;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/cte/inutilizacoes/{id}', 'GET');
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeInutilizacaoFromJson(Response.ContentAsString);
end;

function TCteService.BaixarXmlInutilizacaoCte(Id: string): TBytes;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/cte/inutilizacoes/{id}/xml', 'GET');
  Request.AddUrlParam('id', Id);
  Response := Request.Execute;
  CheckError(Response);
  Result := Response.ContentAsBytes;
end;

function TCteService.EmitirLoteCte(Body: TCtePedidoEmissaoLote): TDfeLote;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/cte/lotes', 'POST');
  Request.AddBody(Converter.TCtePedidoEmissaoLoteToJson(Body));
  Request.AddHeader('Content-Type', 'application/json');
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeLoteFromJson(Response.ContentAsString);
end;

function TCteService.ConsultarLoteCte(Id: string): TDfeLote;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/cte/lotes/{id}', 'GET');
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeLoteFromJson(Response.ContentAsString);
end;

function TCteService.ConsultarStatusSefazCte(CpfCnpj: string): TDfeVisaoGeralSefazStatus;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/cte/sefaz/status', 'GET');
  Request.AddQueryParam('cpf_cnpj', CpfCnpj);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeVisaoGeralSefazStatusFromJson(Response.ContentAsString);
end;

function TCteService.ConsultarCte(Id: string): TDfe;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/cte/{id}', 'GET');
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeFromJson(Response.ContentAsString);
end;

function TCteService.ConsultarCancelamentoCte(Id: string): TDfeCancelamento;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/cte/{id}/cancelamento', 'GET');
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeCancelamentoFromJson(Response.ContentAsString);
end;

function TCteService.CancelarCte(Body: TCtePedidoCancelamento; Id: string): TDfeCancelamento;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/cte/{id}/cancelamento', 'POST');
  Request.AddBody(Converter.TCtePedidoCancelamentoToJson(Body));
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Content-Type', 'application/json');
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeCancelamentoFromJson(Response.ContentAsString);
end;

function TCteService.BaixarXmlCancelamentoCte(Id: string): TBytes;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/cte/{id}/cancelamento/xml', 'GET');
  Request.AddUrlParam('id', Id);
  Response := Request.Execute;
  CheckError(Response);
  Result := Response.ContentAsBytes;
end;

function TCteService.ConsultarCartaCorrecaoCte(Id: string): TCteCartaCorrecao;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/cte/{id}/carta-correcao', 'GET');
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TCteCartaCorrecaoFromJson(Response.ContentAsString);
end;

function TCteService.CriarCartaCorrecaoCte(Body: TCtePedidoCartaCorrecao; Id: string): TCteCartaCorrecao;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/cte/{id}/carta-correcao', 'POST');
  Request.AddBody(Converter.TCtePedidoCartaCorrecaoToJson(Body));
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Content-Type', 'application/json');
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TCteCartaCorrecaoFromJson(Response.ContentAsString);
end;

function TCteService.BaixarXmlCartaCorrecaoCte(Id: string): TBytes;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/cte/{id}/carta-correcao/xml', 'GET');
  Request.AddUrlParam('id', Id);
  Response := Request.Execute;
  CheckError(Response);
  Result := Response.ContentAsBytes;
end;

function TCteService.BaixarXmlCte(Id: string): TBytes;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/cte/{id}/xml', 'GET');
  Request.AddUrlParam('id', Id);
  Response := Request.Execute;
  CheckError(Response);
  Result := Response.ContentAsBytes;
end;

{ TEmpresaService }

function TEmpresaService.ListarEmpresas(Top: Integer; Skip: Integer; CpfCnpj: string): TEmpresaListagem;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/empresas', 'GET');
  Request.AddQueryParam('$top', IntToStr(Top));
  Request.AddQueryParam('$skip', IntToStr(Skip));
  Request.AddQueryParam('cpf_cnpj', CpfCnpj);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TEmpresaListagemFromJson(Response.ContentAsString);
end;

function TEmpresaService.CriarEmpresa(Body: TEmpresa): TEmpresa;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/empresas', 'POST');
  Request.AddBody(Converter.TEmpresaToJson(Body));
  Request.AddHeader('Content-Type', 'application/json');
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TEmpresaFromJson(Response.ContentAsString);
end;

function TEmpresaService.ConsultarEmpresa(CpfCnpj: string): TEmpresa;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/empresas/{cpf_cnpj}', 'GET');
  Request.AddUrlParam('cpf_cnpj', CpfCnpj);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TEmpresaFromJson(Response.ContentAsString);
end;

procedure TEmpresaService.ExcluirEmpresa(CpfCnpj: string);
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/empresas/{cpf_cnpj}', 'DELETE');
  Request.AddUrlParam('cpf_cnpj', CpfCnpj);
  Response := Request.Execute;
  CheckError(Response);
end;

function TEmpresaService.AtualizarEmpresa(Body: TEmpresa; CpfCnpj: string): TEmpresa;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/empresas/{cpf_cnpj}', 'PATCH');
  Request.AddBody(Converter.TEmpresaToJson(Body));
  Request.AddUrlParam('cpf_cnpj', CpfCnpj);
  Request.AddHeader('Content-Type', 'application/json');
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TEmpresaFromJson(Response.ContentAsString);
end;

function TEmpresaService.ConsultarCertificadoEmpresa(CpfCnpj: string): TEmpresaCertificado;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/empresas/{cpf_cnpj}/certificado', 'GET');
  Request.AddUrlParam('cpf_cnpj', CpfCnpj);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TEmpresaCertificadoFromJson(Response.ContentAsString);
end;

function TEmpresaService.CadastrarCertificadoEmpresa(Body: TEmpresaPedidoCadastroCertificado; CpfCnpj: string): TEmpresaCertificado;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/empresas/{cpf_cnpj}/certificado', 'POST');
  Request.AddBody(Converter.TEmpresaPedidoCadastroCertificadoToJson(Body));
  Request.AddUrlParam('cpf_cnpj', CpfCnpj);
  Request.AddHeader('Content-Type', 'application/json');
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TEmpresaCertificadoFromJson(Response.ContentAsString);
end;

procedure TEmpresaService.ExcluirCertificadoEmpresa(CpfCnpj: string);
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/empresas/{cpf_cnpj}/certificado', 'DELETE');
  Request.AddUrlParam('cpf_cnpj', CpfCnpj);
  Response := Request.Execute;
  CheckError(Response);
end;

function TEmpresaService.EnviarCertificadoEmpresa(Input: TBytes; CpfCnpj: string): TEmpresaCertificado;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/empresas/{cpf_cnpj}/certificado/upload', 'POST');
  raise Exception.Create('Form param ''Input'' not supported');
  Request.AddUrlParam('cpf_cnpj', CpfCnpj);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TEmpresaCertificadoFromJson(Response.ContentAsString);
end;

{ TMdfeService }

function TMdfeService.EmitirMdfe(Body: TMdfePedidoEmissao): TDfe;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/mdfe', 'POST');
  Request.AddBody(Converter.TMdfePedidoEmissaoToJson(Body));
  Request.AddHeader('Content-Type', 'application/json');
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeFromJson(Response.ContentAsString);
end;

function TMdfeService.ConsultarEventoMdfe(Id: string): TDfeEvento;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/mdfe/eventos/{id}', 'GET');
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeEventoFromJson(Response.ContentAsString);
end;

function TMdfeService.BaixarXmlEventoMdfe(Id: string): TBytes;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/mdfe/eventos/{id}/xml', 'GET');
  Request.AddUrlParam('id', Id);
  Response := Request.Execute;
  CheckError(Response);
  Result := Response.ContentAsBytes;
end;

function TMdfeService.EmitirLoteMdfe(Body: TMdfePedidoEmissaoLote): TDfeLote;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/mdfe/lotes', 'POST');
  Request.AddBody(Converter.TMdfePedidoEmissaoLoteToJson(Body));
  Request.AddHeader('Content-Type', 'application/json');
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeLoteFromJson(Response.ContentAsString);
end;

function TMdfeService.ConsultarLoteMdfe(Id: string): TDfeLote;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/mdfe/lotes/{id}', 'GET');
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeLoteFromJson(Response.ContentAsString);
end;

function TMdfeService.ConsultarStatusSefazMdfe(CpfCnpj: string): TDfeVisaoGeralSefazStatus;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/mdfe/sefaz/status', 'GET');
  Request.AddQueryParam('cpf_cnpj', CpfCnpj);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeVisaoGeralSefazStatusFromJson(Response.ContentAsString);
end;

function TMdfeService.ConsultarMdfe(Id: string): TDfe;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/mdfe/{id}', 'GET');
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeFromJson(Response.ContentAsString);
end;

function TMdfeService.ConsultarCancelamentoMdfe(Id: string): TDfeCancelamento;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/mdfe/{id}/cancelamento', 'GET');
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeCancelamentoFromJson(Response.ContentAsString);
end;

function TMdfeService.CancelarMdfe(Body: TMdfePedidoCancelamento; Id: string): TDfeCancelamento;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/mdfe/{id}/cancelamento', 'POST');
  Request.AddBody(Converter.TMdfePedidoCancelamentoToJson(Body));
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Content-Type', 'application/json');
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeCancelamentoFromJson(Response.ContentAsString);
end;

function TMdfeService.BaixarXmlCancelamentoMdfe(Id: string): TBytes;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/mdfe/{id}/cancelamento/xml', 'GET');
  Request.AddUrlParam('id', Id);
  Response := Request.Execute;
  CheckError(Response);
  Result := Response.ContentAsBytes;
end;

function TMdfeService.ConsultarEncerramentoMdfe(Id: string): TMdfeEncerramento;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/mdfe/{id}/encerramento', 'GET');
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TMdfeEncerramentoFromJson(Response.ContentAsString);
end;

function TMdfeService.EncerrarMdfe(Body: TMdfePedidoEncerramento; Id: string): TMdfeEncerramento;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/mdfe/{id}/encerramento', 'POST');
  Request.AddBody(Converter.TMdfePedidoEncerramentoToJson(Body));
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Content-Type', 'application/json');
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TMdfeEncerramentoFromJson(Response.ContentAsString);
end;

function TMdfeService.BaixarXmlEncerramentoMdfe(Id: string): TBytes;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/mdfe/{id}/encerramento/xml', 'GET');
  Request.AddUrlParam('id', Id);
  Response := Request.Execute;
  CheckError(Response);
  Result := Response.ContentAsBytes;
end;

function TMdfeService.IncluirCondutorMdfe(Body: TMdfePedidoInclusaoCondutor; Id: string): TMdfeInclusaoCondutor;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/mdfe/{id}/inclusao-condutor', 'POST');
  Request.AddBody(Converter.TMdfePedidoInclusaoCondutorToJson(Body));
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Content-Type', 'application/json');
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TMdfeInclusaoCondutorFromJson(Response.ContentAsString);
end;

function TMdfeService.IncluirDfeMdfe(Body: TMdfePedidoInclusaoDfe; Id: string): TMdfeInclusaoDfe;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/mdfe/{id}/inclusao-dfe', 'POST');
  Request.AddBody(Converter.TMdfePedidoInclusaoDfeToJson(Body));
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Content-Type', 'application/json');
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TMdfeInclusaoDfeFromJson(Response.ContentAsString);
end;

function TMdfeService.BaixarXmlMdfe(Id: string): TBytes;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/mdfe/{id}/xml', 'GET');
  Request.AddUrlParam('id', Id);
  Response := Request.Execute;
  CheckError(Response);
  Result := Response.ContentAsBytes;
end;

{ TNfceService }

function TNfceService.EmitirNfce(Body: TNfePedidoEmissao): TDfe;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfce', 'POST');
  Request.AddBody(Converter.TNfePedidoEmissaoToJson(Body));
  Request.AddHeader('Content-Type', 'application/json');
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeFromJson(Response.ContentAsString);
end;

function TNfceService.InutilizarNfce(Body: TDfePedidoInutilizacao): TDfeInutilizacao;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfce/inutilizacoes', 'POST');
  Request.AddBody(Converter.TDfePedidoInutilizacaoToJson(Body));
  Request.AddHeader('Content-Type', 'application/json');
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeInutilizacaoFromJson(Response.ContentAsString);
end;

function TNfceService.ConsultarInutilizacaoNfce(Id: string): TDfeInutilizacao;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfce/inutilizacoes/{id}', 'GET');
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeInutilizacaoFromJson(Response.ContentAsString);
end;

function TNfceService.BaixarXmlInutilizacaoNfce(Id: string): TBytes;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfce/inutilizacoes/{id}/xml', 'GET');
  Request.AddUrlParam('id', Id);
  Response := Request.Execute;
  CheckError(Response);
  Result := Response.ContentAsBytes;
end;

function TNfceService.EmitirLoteNfce(Body: TNfePedidoEmissaoLote): TDfeLote;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfce/lotes', 'POST');
  Request.AddBody(Converter.TNfePedidoEmissaoLoteToJson(Body));
  Request.AddHeader('Content-Type', 'application/json');
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeLoteFromJson(Response.ContentAsString);
end;

function TNfceService.ConsultarLoteNfce(Id: string): TDfeLote;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfce/lotes/{id}', 'GET');
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeLoteFromJson(Response.ContentAsString);
end;

function TNfceService.ConsultarStatusSefazNfce(CpfCnpj: string): TDfeVisaoGeralSefazStatus;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfce/sefaz/status', 'GET');
  Request.AddQueryParam('cpf_cnpj', CpfCnpj);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeVisaoGeralSefazStatusFromJson(Response.ContentAsString);
end;

function TNfceService.ConsultarNfce(Id: string): TDfe;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfce/{id}', 'GET');
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeFromJson(Response.ContentAsString);
end;

function TNfceService.ConsultarCancelamentoNfce(Id: string): TDfeCancelamento;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfce/{id}/cancelamento', 'GET');
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeCancelamentoFromJson(Response.ContentAsString);
end;

function TNfceService.CancelarNfce(Body: TNfePedidoCancelamento; Id: string): TDfeCancelamento;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfce/{id}/cancelamento', 'POST');
  Request.AddBody(Converter.TNfePedidoCancelamentoToJson(Body));
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Content-Type', 'application/json');
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeCancelamentoFromJson(Response.ContentAsString);
end;

function TNfceService.BaixarXmlCancelamentoNfce(Id: string): TBytes;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfce/{id}/cancelamento/xml', 'GET');
  Request.AddUrlParam('id', Id);
  Response := Request.Execute;
  CheckError(Response);
  Result := Response.ContentAsBytes;
end;

function TNfceService.BaixarPdfNfce(Id: string): TBytes;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfce/{id}/pdf', 'GET');
  Request.AddUrlParam('id', Id);
  Response := Request.Execute;
  CheckError(Response);
  Result := Response.ContentAsBytes;
end;

function TNfceService.BaixarXmlNfce(Id: string): TBytes;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfce/{id}/xml', 'GET');
  Request.AddUrlParam('id', Id);
  Response := Request.Execute;
  CheckError(Response);
  Result := Response.ContentAsBytes;
end;

{ TNfeService }

function TNfeService.EmitirNfe(Body: TNfePedidoEmissao): TDfe;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfe', 'POST');
  Request.AddBody(Converter.TNfePedidoEmissaoToJson(Body));
  Request.AddHeader('Content-Type', 'application/json');
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeFromJson(Response.ContentAsString);
end;

function TNfeService.ConsultarEventoNfe(Id: string): TDfeEvento;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfe/eventos/{id}', 'GET');
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeEventoFromJson(Response.ContentAsString);
end;

function TNfeService.BaixarXmlEventoNfe(Id: string): TBytes;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfe/eventos/{id}/xml', 'GET');
  Request.AddUrlParam('id', Id);
  Response := Request.Execute;
  CheckError(Response);
  Result := Response.ContentAsBytes;
end;

function TNfeService.InutilizarNfe(Body: TDfePedidoInutilizacao): TDfeInutilizacao;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfe/inutilizacoes', 'POST');
  Request.AddBody(Converter.TDfePedidoInutilizacaoToJson(Body));
  Request.AddHeader('Content-Type', 'application/json');
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeInutilizacaoFromJson(Response.ContentAsString);
end;

function TNfeService.ConsultarInutilizacaoNfe(Id: string): TDfeInutilizacao;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfe/inutilizacoes/{id}', 'GET');
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeInutilizacaoFromJson(Response.ContentAsString);
end;

function TNfeService.BaixarXmlInutilizacaoNfe(Id: string): TBytes;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfe/inutilizacoes/{id}/xml', 'GET');
  Request.AddUrlParam('id', Id);
  Response := Request.Execute;
  CheckError(Response);
  Result := Response.ContentAsBytes;
end;

function TNfeService.EmitirLoteNfe(Body: TNfePedidoEmissaoLote): TDfeLote;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfe/lotes', 'POST');
  Request.AddBody(Converter.TNfePedidoEmissaoLoteToJson(Body));
  Request.AddHeader('Content-Type', 'application/json');
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeLoteFromJson(Response.ContentAsString);
end;

function TNfeService.ConsultarLoteNfe(Id: string): TDfeLote;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfe/lotes/{id}', 'GET');
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeLoteFromJson(Response.ContentAsString);
end;

function TNfeService.ConsultarStatusSefazNfe(CpfCnpj: string): TDfeVisaoGeralSefazStatus;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfe/sefaz/status', 'GET');
  Request.AddQueryParam('cpf_cnpj', CpfCnpj);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeVisaoGeralSefazStatusFromJson(Response.ContentAsString);
end;

function TNfeService.ConsultarNfe(Id: string): TDfe;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfe/{id}', 'GET');
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeFromJson(Response.ContentAsString);
end;

function TNfeService.ConsultarCancelamentoNfe(Id: string): TDfeCancelamento;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfe/{id}/cancelamento', 'GET');
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeCancelamentoFromJson(Response.ContentAsString);
end;

function TNfeService.CancelarNfe(Body: TNfePedidoCancelamento; Id: string): TDfeCancelamento;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfe/{id}/cancelamento', 'POST');
  Request.AddBody(Converter.TNfePedidoCancelamentoToJson(Body));
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Content-Type', 'application/json');
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeCancelamentoFromJson(Response.ContentAsString);
end;

function TNfeService.BaixarXmlCancelamentoNfe(Id: string): TBytes;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfe/{id}/cancelamento/xml', 'GET');
  Request.AddUrlParam('id', Id);
  Response := Request.Execute;
  CheckError(Response);
  Result := Response.ContentAsBytes;
end;

function TNfeService.ConsultarCartaCorrecaoNfe(Id: string): TDfeCartaCorrecao;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfe/{id}/carta-correcao', 'GET');
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeCartaCorrecaoFromJson(Response.ContentAsString);
end;

function TNfeService.CriarCartaCorrecaoNfe(Body: TNfePedidoCartaCorrecao; Id: string): TDfeCartaCorrecao;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfe/{id}/carta-correcao', 'POST');
  Request.AddBody(Converter.TNfePedidoCartaCorrecaoToJson(Body));
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Content-Type', 'application/json');
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TDfeCartaCorrecaoFromJson(Response.ContentAsString);
end;

function TNfeService.BaixarXmlCartaCorrecaoNfe(Id: string): TBytes;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfe/{id}/carta-correcao/xml', 'GET');
  Request.AddUrlParam('id', Id);
  Response := Request.Execute;
  CheckError(Response);
  Result := Response.ContentAsBytes;
end;

function TNfeService.BaixarPdfNfe(Id: string): TBytes;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfe/{id}/pdf', 'GET');
  Request.AddUrlParam('id', Id);
  Response := Request.Execute;
  CheckError(Response);
  Result := Response.ContentAsBytes;
end;

function TNfeService.BaixarXmlNfe(Id: string): TBytes;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfe/{id}/xml', 'GET');
  Request.AddUrlParam('id', Id);
  Response := Request.Execute;
  CheckError(Response);
  Result := Response.ContentAsBytes;
end;

{ TNfseService }

function TNfseService.ListarNfse(Top: Integer; Skip: Integer; CpfCnpj: string; Referencia: string; Ambiente: string): TNfseListagem;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfse', 'GET');
  Request.AddQueryParam('$top', IntToStr(Top));
  Request.AddQueryParam('$skip', IntToStr(Skip));
  Request.AddQueryParam('cpf_cnpj', CpfCnpj);
  Request.AddQueryParam('referencia', Referencia);
  Request.AddQueryParam('ambiente', Ambiente);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TNfseListagemFromJson(Response.ContentAsString);
end;

function TNfseService.EmitirNfse(Body: TNfsePedidoEmissao): TNfse;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfse', 'POST');
  Request.AddBody(Converter.TNfsePedidoEmissaoToJson(Body));
  Request.AddHeader('Content-Type', 'application/json');
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TNfseFromJson(Response.ContentAsString);
end;

function TNfseService.ListarLotesNfse(Top: Integer; Skip: Integer; CpfCnpj: string; Referencia: string; Ambiente: string): TRpsLoteListagem;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfse/lotes', 'GET');
  Request.AddQueryParam('$top', IntToStr(Top));
  Request.AddQueryParam('$skip', IntToStr(Skip));
  Request.AddQueryParam('cpf_cnpj', CpfCnpj);
  Request.AddQueryParam('referencia', Referencia);
  Request.AddQueryParam('ambiente', Ambiente);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TRpsLoteListagemFromJson(Response.ContentAsString);
end;

function TNfseService.EmitirLoteNfse(Body: TRpsPedidoEmissaoLote): TRpsLote;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfse/lotes', 'POST');
  Request.AddBody(Converter.TRpsPedidoEmissaoLoteToJson(Body));
  Request.AddHeader('Content-Type', 'application/json');
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TRpsLoteFromJson(Response.ContentAsString);
end;

function TNfseService.ConsultarLoteNfse(Id: string): TRpsLote;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfse/lotes/{id}', 'GET');
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TRpsLoteFromJson(Response.ContentAsString);
end;

function TNfseService.ConsultarNfse(Id: string): TNfse;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfse/{id}', 'GET');
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TNfseFromJson(Response.ContentAsString);
end;

function TNfseService.ConsultarCancelamentoNfse(Id: string): TNfseCancelamento;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfse/{id}/cancelamento', 'GET');
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TNfseCancelamentoFromJson(Response.ContentAsString);
end;

function TNfseService.CancelarNfse(Id: string): TNfseCancelamento;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfse/{id}/cancelamento', 'POST');
  Request.AddUrlParam('id', Id);
  Request.AddHeader('Accept', 'application/json');
  Response := Request.Execute;
  CheckError(Response);
  Result := Converter.TNfseCancelamentoFromJson(Response.ContentAsString);
end;

function TNfseService.BaixarXmlNfse(Id: string): TBytes;
var
  Request: IRestRequest;
  Response: IRestResponse;
begin
  Request := CreateRequest('/nfse/{id}/xml', 'GET');
  Request.AddUrlParam('id', Id);
  Response := Request.Execute;
  CheckError(Response);
  Result := Response.ContentAsBytes;
end;

{ TNuvemFiscalConfig }

constructor TNuvemFiscalConfig.Create;
begin
  inherited Create;
  BaseUrl := 'https://api.nuvemfiscal.com.br/';
end;

{ TNuvemFiscalClient }

function TNuvemFiscalClient.Cep: ICepService;
begin
  Result := TCepService.Create(Config);
end;

function TNuvemFiscalClient.Cnpj: ICnpjService;
begin
  Result := TCnpjService.Create(Config);
end;

function TNuvemFiscalClient.Cte: ICteService;
begin
  Result := TCteService.Create(Config);
end;

function TNuvemFiscalClient.Empresa: IEmpresaService;
begin
  Result := TEmpresaService.Create(Config);
end;

function TNuvemFiscalClient.Mdfe: IMdfeService;
begin
  Result := TMdfeService.Create(Config);
end;

function TNuvemFiscalClient.Nfce: INfceService;
begin
  Result := TNfceService.Create(Config);
end;

function TNuvemFiscalClient.Nfe: INfeService;
begin
  Result := TNfeService.Create(Config);
end;

function TNuvemFiscalClient.Nfse: INfseService;
begin
  Result := TNfseService.Create(Config);
end;

constructor TNuvemFiscalClient.Create;
begin
  inherited Create(TNuvemFiscalConfig.Create);
end;

end.
