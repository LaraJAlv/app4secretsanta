<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;

class MensagemController extends Controller
{

    public function lista (Request $request, string $usr) {
        
        $mensagens = DB::select('CALL ST_USUARIOS_MENSAGENS_LISTA(?)',[$usr]);
        return response()->json($mensagens);

    }


    public function seleciona (Request $request) {

        $CD_Usuario = (string) $request->input('CD_Usuario');
        $CD_UsuarioDestino = (string) $request->input('CD_UsuarioDestino');
        $fl_Anonimo = (integer) $request->input('fl_Anonimo');

        $mensagens = DB::select('CALL ST_USUARIOS_MENSAGENS_SELECT(?,?,?)',[$CD_Usuario,$CD_UsuarioDestino,$fl_Anonimo]);
        return response()->json($mensagens);

    }

    public function insere (Request $request) {

        $CD_Usuario = (string) $request->input('CD_Usuario');
        $CD_UsuarioDestino = (string) $request->input('CD_UsuarioDestino');
        $tx_Mensagem = (string) $request->input('tx_Mensagem');
        $fl_Anonimo = (integer) $request->input('fl_Anonimo');
        
        $mensagem = DB::select('CALL ST_USUARIOS_MENSAGENS_INSERT(?,?,?,?)',[$CD_Usuario,$CD_UsuarioDestino,$tx_Mensagem,$fl_Anonimo]);
        if (!empty($mensagem)) {
            $mensagem = $mensagem[0];
        }

        return response()->json($mensagem);

    }

}