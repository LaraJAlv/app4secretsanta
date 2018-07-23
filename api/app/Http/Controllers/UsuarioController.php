<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Firebase\JWT\JWT;

class UsuarioController extends Controller
{

    public function login (Request $request) {
        
        $CD_Usuario  = (string) $request->input('CD_Usuario');
        $CD_Token = (string) $request->input('CD_Token');
        $nm_Usuario = (string) $request->input('nm_Usuario');
        $nm_Email = (string) $request->input('nm_Email');
        $nm_Imagem = (string) 'https://graph.facebook.com/'.$request->input('CD_Usuario').'/picture?type=large';

        $usuario = DB::select('CALL ST_USUARIOS_INSERT(?,?,?,?,?)',[$CD_Usuario,$CD_Token,$nm_Usuario,$nm_Email,$nm_Imagem]);

        if (!empty($usuario)) {
            $usuario = $usuario[0];
        }

        return response()->json(JWT::encode($usuario, env('JWT_SECRET')));

    }

    public function profile (Request $request, string $usr) {
        
        $usr = (string) $usr;
        $usuario = DB::select('CALL ST_USUARIOS_SELECT(?)',[$usr]);

        if (!empty($usuario)) {
            $usuario = $usuario[0];
        }

        return response()->json($usuario);

    }

}
