export interface Participante {
    ID_Usuario: number;
    CD_Usuario?: string;
    CD_Token?: string;
    nm_Usuario: string;
    nm_Email?: string;
    nm_Imagem: string;
    fl_Proprietario?: boolean;
    dt_Sorteio?: Date;
    tx_Dica?: string;
    nm_Link?: string;
}

export interface Dica {
    ID_Usuario?: number;
    CD_Usuario?: string;
    ID_Grupo?: number;
    tx_Dica: string;
    nm_Link: string;
}