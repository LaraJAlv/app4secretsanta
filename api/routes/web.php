<?php

$router->get('/', function () use ($router) {
    return $router->app->version();
});

$router->group(['prefix' => 'usuario'], function () use ($router) {
    $router->post('/', 'UsuarioController@login');

	$router->get('/{usr}', 'UsuarioController@profile');
});

$router->group(['prefix' => 'grupos'], function () use ($router) {
	$router->get('/{usr}', 'GrupoController@lista');
	$router->get('/{usr}/{id:[0-9]+}', 'GrupoController@seleciona');

    $router->post('/', 'GrupoController@insere');

    $router->delete('/{usr:[0-9]+}/{id:[0-9]+}', 'GrupoController@exclui');
});

$router->group(['prefix' => 'participantes'], function () use ($router) {
	$router->get('/{usr}/{id:[0-9]+}', 'ParticipantesController@lista');
	$router->get('/{usr}/{id:[0-9]+}/{idusr:[0-9]+}', 'ParticipantesController@propriedade');

	$router->post('/', 'ParticipantesController@insere');
	$router->post('/propriedade', 'ParticipantesController@atualiza');

	$router->delete('/{usr}/{id:[0-9]+}/{idusr:[0-9]+}', 'ParticipantesController@exclui');
});

$router->group(['prefix' => 'sorteio'], function () use ($router) {
	$router->get('/{usr}/{id:[0-9]+}', 'ParticipantesController@sorteio_seleciona');
	$router->post('/', 'ParticipantesController@sorteio');
	$router->delete('/{usr}/{id:[0-9]+}', 'ParticipantesController@sorteio_exclui');
});

$router->group(['prefix' => 'dicas'], function () use ($router) {
	$router->get('/{usr}/{id:[0-9]+}', 'DicaController@seleciona');
    $router->post('/', 'DicaController@insere');
    $router->delete('/{usr:[0-9]+}/{id:[0-9]+}', 'DicaController@exclui');
});

$router->group(['prefix' => 'mensagens'], function () use ($router) {
	$router->get('/{usr}', 'MensagemController@lista');
	$router->post('/seleciona', 'MensagemController@seleciona');
    $router->post('/', 'MensagemController@insere');
});
