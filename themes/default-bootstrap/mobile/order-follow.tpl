<div class="col-xs-12 col-sm-12">
    {capture name=path}
        <a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}">
            {l s='My account'}
        </a>
        <span class="navigation-pipe">
		{$navigationPipe}
	</span>
        <span class="navigation_page">
		{l s='My returns'}
	</span>
    {/capture}
    <div class="page-header">
        <div>
            {include file="{$tpl_dir}mobile/espace_client_sublinks.tpl" titleAccordion={l s='Mes retours'}}
        </div>
        {include file="{$tpl_dir}mobile/my-account-add-address.tpl"}
        <div class="clearfix"></div>
    </div>
    <div class="my-account-content-block">
        <p>{l s='Si, malgré tous nos efforts un article ne vous apportait pas entière satisfaction, vous avez la possibilité de nous retourner cet article. Pour retourner un article de votre commande, vous devez prendre contact avec notre service client par e-mail ou par téléphone en nous indiquant la référence de la commande afin que nous organisions le retour de l’article.'}
            <br/><br/>
            {l s='Vous disposez d’un délai de 14 jours calendaires (dimanches et jours fériés compris) à compter de la réception de votre article pour nous indiquer votre souhait d’effectuer un retour. Ensuite, nous organiserons pour vous la reprise de cet article.'}
            <br/><br/>
            <a href="{$link->getPageLink('contact', true)|escape:'html':'UTF-8'}?id_contact=4">{l s='Cliquez ici pour contacter notre Service Client via le formulaire de contact'}</a>
        </p>
    </div>
</div>