<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;

class DicaController extends Controller
{

    public function seleciona (Request $request, string $usr, $id) {

        $id = (integer) $id;
        $dica = DB::select('CALL ST_GRUPOS_USUARIOS_DICAS_SELECT(?,?)',[$usr,$id]);

        if (!empty($dica)) {
            $dica = $dica[0];
        }

        return response()->json($dica);

    }

    public function exclui (Request $request, string $usr, $id) {

        $id = (integer) $id;
        $retorno = DB::select('CALL ST_GRUPOS_USUARIOS_DICAS_DELETE(?,?)',[$usr,$id]);
        return response()->json($retorno);

    }

    public function insere (Request $request) {

        $CD_Usuario = (string) $request->input('CD_Usuario');
        $ID_Grupo = (integer) $request->input('ID_Grupo');
        $tx_Dica = (string) $request->input('tx_Dica');
        $nm_Link = (string) $request->input('nm_Link');
        
        $retorno = DB::select('CALL ST_GRUPOS_USUARIOS_DICAS_INSERT(?,?,?,?)',[$CD_Usuario,$ID_Grupo,$tx_Dica,$nm_Link]);

        return response()->json($retorno);

    }

}