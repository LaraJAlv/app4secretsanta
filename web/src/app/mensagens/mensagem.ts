export interface Mensagem {
    ID_Mensagem?: number;
    ID_MensagemPai?: number;
    ID_Usuario?: number;
    ID_UsuarioDestino?: number;
    CD_Usuario?: string;
    CD_UsuarioDestino?: string;
    nm_Usuario?: string;
    tx_Mensagem: string;
    dt_Mensagem?: Date;
    fl_Anonimo?: number;
    fl_Lido?: boolean;
    nr_Lidos?: number;
}