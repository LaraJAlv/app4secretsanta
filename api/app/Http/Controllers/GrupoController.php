<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Illuminate\Mail\Mailable;

class GrupoController extends Controller
{
    
    public function lista (Request $request, string $usr) {
        
        $grupos = DB::select('CALL ST_GRUPOS_LISTA(?)',[$usr]);
        return response()->json($grupos);

    }

    public function seleciona (Request $request, string $usr, $id) {
        
        $id = (integer) $id;

        $grupo = DB::select('CALL ST_GRUPOS_SELECT(?,?)',[$usr,$id]);
        if (!empty($grupo)) {
            $grupo = $grupo[0];
        }
        return response()->json($grupo);

    }

    public function insere (Request $request) {

        $ID_Grupo = (integer) $request->input('ID_Grupo');
        $CD_Usuario = (string) $request->input('CD_Usuario');
        $nm_Grupo = (string) $request->input('nm_Grupo');
        $tx_Grupo = (string) $request->input('tx_Grupo');

        if (empty($ID_Grupo)) {
            $retorno = DB::select('CALL ST_GRUPOS_INSERT(?,?,?)',[$CD_Usuario,$nm_Grupo,$tx_Grupo]);
        } else {
            $retorno = DB::select('CALL ST_GRUPOS_UPDATE(?,?,?,?)',[$CD_Usuario,$ID_Grupo,$nm_Grupo,$tx_Grupo]);
        }
        if (!empty($retorno)) {
            $retorno = $retorno[0]->ID_Grupo;
        }

        return response()->json($retorno);

    }

    public function exclui (Request $request, string $usr, $id) {
        
        $id = (integer) $id;
        $grupo = DB::select('CALL ST_GRUPOS_DELETE(?,?)',[$usr,$id]);
        return response()->json($grupo);

    }

}