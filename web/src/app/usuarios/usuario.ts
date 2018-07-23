export interface Usuario {
    ID_Usuario?: number;
    CD_Usuario: string;
    CD_Token?: string;
    nm_Usuario: string;
    nm_Email: string;
    nm_Imagem: string;
    nr_Grupos?: number;
    nr_GruposProprietario?: number;
    nr_Mensagens?: number;
    fl_Proprietario?: number;
}