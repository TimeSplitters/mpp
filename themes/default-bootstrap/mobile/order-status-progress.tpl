{if isset($current)}
{assign var=liststatus value=OrderStateCore::getOrderStates(1)}

{$statusclass=[
	1 =>['id_status'=>2,'desc'=>'<b>VALIDÉE</b><br/>Votre commande a été prise en charge et est désormais validée.','fawicon'=>'icon-shopping-cart','instock'=>true],
	2 =>['id_status'=>3,'desc'=>'<b>FABRICATION</b><br/>C’est parti, la fabrication de vos articles est en cours. Nos artisans travaillent avec le plus grand soin pour créer vos meubles !','fawicon'=>'icon-wrench','instock'=>false],
	3 =>['id_status'=>19,'desc'=>'<b>CONTRÔLE QUALITÉ #1</b><br/>La fabrication de vos articles est achevée ! Avant leur sortie de l’atelier, chacun de nos articles doit réussir des tests pour obtenir la validation de nos experts qualité.','fawicon'=>'icon-tasks','instock'=>false],
	4 =>['id_status'=>20,'desc'=>'<b>ACHEMINEMENT DE VOS ARTICLES VERS NOS ENTREPÔTS</b><br/>Votre commande est conforme à nos exigences et elle est désormais en route vers nos centres logistiques. Nous vous enverrons un Email dès son arrivée, avec les dates d’expédition et de livraison chez vous.','fawicon'=>'icon-ship','instock'=>false],
	5 =>['id_status'=>23,'desc'=>'<b>CONTRÔLE QUALITÉ #2</b><br/>Votre commande est arrivée dans notre centre logistique ! Comme nous ne laissons rien au hasard, nous nous assurons du bon état de chaque article avant de le remettre à notre transporteur.','fawicon'=>'icon-search','instock'=>false],
	6 =>['id_status'=>4,'desc'=>'<b>EXPÉDIÉE</b><br/>La commande est entre les mains de notre transporteur qui sonnera bientôt à votre porte ! Surveillez vos Emails : il est peut être déjà en train de vous contacter pour prendre RDV.','fawicon'=>'icon-truck','instock'=>true],
	7 =>['id_status'=>5,'desc'=>'<b>LIVRÉE</b><br/>Votre commande est livrée chez vous ! Nous esperons que vous êtes satisfait(e) de votre achat. À la moindre question, n\'hésitez pas à contacter notre #SuperServiceClient !','fawicon'=>'icon-check','instock'=>true],
	8 =>['id_status'=>6,'desc'=>'<b>ANNULÉE</b><br/>Votre commande a été annulée.','fawicon'=>'icon-remove','instock'=>false]
	]
	}
{$sorted_status=[]}
{foreach $statusclass as $status}
{assign var=stid value=$status.id_status}
	{foreach $liststatus as $lstatus}
		{if $lstatus.id_order_state==$stid && (($instock==1 && $status.instock==$instock) || $instock==false)  }
			{$sorted_status[$status@key]=$lstatus}
		{/if}
	{/foreach}
{/foreach}
{assign var=clcurrent value="active-state"}
{foreach $sorted_status as $status}
	{if $current==$status.id_order_state}
		<div class="pull-left text-uppercase">{$status.name}</div>
	{/if}
{/foreach}
<ul class="list-inline statuses">
{foreach $sorted_status as $status}
{$cstatus=$statusclass[$status@key]}
{if $cstatus}
	{if $cstatus.id_status==$current}
		{assign var=clcurrent value="current-state"}
	{elseif $clcurrent=="current-state" or $clcurrent==""}
		{assign var=clcurrent value=""}
	{else}
		{assign var=clcurrent value="active-state"}
	{/if}
	{if $current!=6 || ($current==6 && $status@key==8)}
		<li class="{$clcurrent}" data-toggle="tooltip" data-html="true" data-placement="bottom" data-trigger="manual" class="light-tooltip" title="{$cstatus.desc}">
			<span class="icon-stack icon-inverse">
				<span class="{$cstatus.fawicon} icon icon-stack-1x"></span>
			</span>
		</li>
	{/if}
{/if}
{/foreach}
</ul>
{*var_dump($liststatus)*}
{/if}