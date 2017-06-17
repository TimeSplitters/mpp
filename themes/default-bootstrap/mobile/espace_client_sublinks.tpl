<div id="accordion" class="panel-group panel-espace-client">
    <!-- INFOS -->
    <div class="panel panel-default">
        <div class="panel-heading">
            <h2 class="panel-title text-uppercase">
                <a data-toggle="collapse" data-target="#collapseEspaceClient" class="collapsed"
                   href="#collapseEspaceClient">{$titleAccordion}</a>
            </h2>
        </div>
        <div id="collapseEspaceClient" class="collapse">
            <a href="{$link->getPageLink('identity', true)|escape:'html':'UTF-8'}">
                {l s='Mes informations personnelles / Newsletter'}
            </a>
            <br />
            <a href="{$link->getPageLink('addresses', true)|escape:'html':'UTF-8'}">
                {l s='Ajouter une adresse de livraison / facturation'}
            </a>
            <br />
            <a href="{$link->getPageLink('history', true)|escape:'html':'UTF-8'}">
                {l s='Suivre mes commandes'}
            </a>
            <br />
            <a href="{$link->getPageLink('order-follow', true)|escape:'html':'UTF-8'}">
                {l s='Retourner un produit'}
            </a>
            <br />
            <a href="{$link->getModuleLink('blockwishlist', 'mywishlist', array(), true)|escape:'html':'UTF-8'}">
                {l s='Voir mes produits favoris'}
            </a>
            <br />
            <a href="{$link->getPageLink('contact', true)|escape:'html':'UTF-8'}">
                {l s='Contacter le service client'}
            </a>
        </div>
    </div>
</div>
