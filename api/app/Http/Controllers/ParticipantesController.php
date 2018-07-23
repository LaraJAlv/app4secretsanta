<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;
use Illuminate\Http\Request;

use App\Mail\SorteioMail;

class ParticipantesController extends Controller
{

    public function lista (Request $request, string $usr, $id) {

        $id = (integer) $id;
        $participantes = DB::select('CALL ST_GRUPOS_USUARIOS_LISTA(?,?)',[$usr,$id]);
        return response()->json($participantes);

    }

    public function insere (Request $request) {

        $ID_Grupo = (integer) $request->input('ID_Grupo');
        $CD_Usuario = (string) $request->input('CD_Usuario');

        $retorno = DB::select('CALL ST_GRUPOS_USUARIOS_INSERT(?,?)',[$CD_Usuario,$ID_Grupo]);

        return response()->json($retorno);

    }

    public  function atualiza (Request $request) {

        $CD_Usuario = (string) $request->input('CD_Usuario');
        $ID_Grupo = (integer) $request->input('ID_Grupo');
        $ID_Usuario = (integer) $request->input('ID_Usuario');
        $fl_Propriedade = (boolean) $request->input('fl_Propriedade');

        $retorno = DB::select('CALL ST_GRUPOS_USUARIOS_UPDATE(?,?,?,?)',[$CD_Usuario,$ID_Grupo,$ID_Usuario,$fl_Propriedade]);

        return response()->json($retorno);

    }

    public function propriedade (Request $request, string $usr, $id, $idusr) {

        $id = (integer) $id;
        $idusr = (integer) $idusr;
        $retorno = DB::select('CALL ST_GRUPOS_USUARIOS_LISTA(?,?)',[$usr,$id]);
        return response()->json($retorno);

    }

    public function exclui (Request $request, string $usr, $id, $idusr) {

        $id = (integer) $id;
        $idusr = (integer) $idusr;
        $retorno = DB::select('CALL ST_GRUPOS_USUARIOS_DELETE(?,?,?)',[$usr,$id,$idusr]);
        return response()->json($retorno);

    }

    public function sorteio_seleciona (Request $request, string $usr, $id) {
        
        $id = (integer) $id;

        $participante = DB::select('CALL ST_GRUPOS_SORTEIO_SELECT(?,?)',[$usr,$id]);
        if (!empty($participante)) {
            $participante = $participante[0];
        }
        return response()->json($participante);

    }

    public function sorteio (Request $request) {

        $ID_Grupo = (integer) $request->input('ID_Grupo');
        $CD_Usuario = (string) $request->input('CD_Usuario');
        
        $participantes = DB::select('CALL ST_GRUPOS_SORTEIO_INSERT(?,?)',[$CD_Usuario,$ID_Grupo]);

        try {
            foreach ($participantes as $key => $participante) {
                Mail::to($participante->nm_Email)->send(new SorteioMail($participante->nm_Usuario, $participante->nm_Grupo, $participante->nm_Amigo, $participante->nm_ImagemAmigo));
            }            
        } catch (Exception $e) { }

        return response()->json( array( 'ID_Grupo' => $ID_Grupo, 'dt_Sorteio' => $participantes[0]->dt_Sorteio ) );

    }

    public function sorteio_exclui (Request $request, string $usr, $id) {

        $id = (integer) $id;
        $retorno = DB::select('CALL ST_GRUPOS_SORTEIO_DELETE(?,?)',[$usr,$id]);
        return response()->json($retorno);

    }

}