export interface Grupo {
    ID_Usuario?: number;
    CD_Usuario?: string;
    ID_Grupo?: number;
    nm_Grupo: string;
    tx_Grupo: string;
    dt_Cadastro?: Date;
    dt_Sorteio?: Date;
    fl_Proprietario?: boolean;
}

export interface GrupoRetorno {
    ID_Grupo?: number;
    dt_Sorteio?: Date;
}