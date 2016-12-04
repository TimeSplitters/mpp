<div class="row gutter-10">
    <div class="product_choice col-xs-12">
        <h4>
            <a href="#product_choice_choisir_film">
                <span class="icon-caret-down pull-xs-right"></span> <span
                        class="icon-hand"></span> <input type="radio" class="hidden" name="product_choice" value="film"
                                                         id="product_choice_film"> <label
                        for="product_choice_film">{l s='Je choisis mon film'}</label>
            </a>
        </h4>
        <div id="product_choice_choisir_film" class="row">
            <div class="form-group col-xs-12">
                <label for="film_name">{l s='Titre du film souhaité'}: </label>
                <input type="text" name="film_name" id="film_name" class="form-control"/>
                {*<button name="film_name_search" class="col-xs-2 btn btn-default">
                    <span class="icon-search"></span>
                </button>
            <div id="search_film"></div>*}
            </div>
        </div>
    </div>
    <div class="product_choice col-xs-12">
        <h4>
            <a href="#product_choice_surprise">
                <span class="icon-caret-down pull-xs-right"></span> <span
                        class="icon-gift"></span> <input type="radio" class="hidden" name="product_choice" value="surprise"
                                                         id="product_choice_questionnaire"> <label
                        for="product_choice_questionnaire">{l s='Je vous laisse choisir'}</label>
            </a>
        </h4>
        <div id="product_choice_surprise" class="row">
            <div class="col-xs-12">
                <div>{l s='Nous choisissons pour vous le meilleur DVD selon les critères suivants :'} </div>
                <h5>{l s='Vous êtes :'}</h5>
                <input type="radio" name="gender" value="Un homme" id="gender_homme"/> <label
                        for="gender_homme">{l s='Un homme'}</label>
                <br/>
                <input type="radio" name="gender" value="Une femme" id="gender_femme"/> <label
                        for="gender_femme">{l s='Une femme'}</label>

                <h5>{l s='Vous avez entre :'}</h5>
                <div class="row gutter-10">
                    <div class="col-xs-6">
                        <input type="radio" name="age_range" value="13-17 ans" id="age_13-17"/>
                        <label
                                for="age_13-17">{l s='13-17 ans'}</label>
                        <br/>
                        <input type="radio" name="age_range" value="18-24 ans" id="age_18-24"/>
                        <label
                                for="age_18-24">{l s='18-24 ans'}</label>
                        <br/>
                        <input type="radio" name="age_range" value="25-34 ans" id="age_25-34"/>
                        <label
                                for="age_25-34">{l s='25-34 ans'}</label>
                        <br/>
                        <input type="radio" name="age_range" value="35-44 ans" id="age_35-44"/>
                        <label
                                for="age_35-44">{l s='35-44 ans'}</label>
                    </div>
                    <div class="col-xs-6">
                        <input type="radio" name="age_range" value="45-54 ans" id="age_45-54"/>
                        <label
                                for="age_45-54">{l s='45-54 ans'}</label>
                        <br/>
                        <input type="radio" name="age_range" value="55-64 ans" id="age_55-64"/>
                        <label
                                for="age_55-64">{l s='55-64 ans'}</label>
                        <br/>
                        <input type="radio" name="age_range" value="65+" id="age_65"/> <label
                                for="age_65">{l s='65+'}</label>
                    </div>
                </div>

                <br/>
                <h5>{l s='Quel genre souhaitez-vous ?'}</h5>
                <input type="radio" name="genre" value="Comédie"
                       id="comedie"/> <label
                        for="comedie">{l s='Comédie'}</label>
                <br/>
                <input type="radio" name="genre" value="Drame"
                       id="drame"/> <label
                        for="drame">{l s='Drame'}</label>
                <br/>
                <input type="radio" name="genre" value="Romance" id="romance"/> <label
                        for="romance">{l s='Romance'}</label>
                <br/>
                <input type="radio" name="genre" value="Action"
                       id="action"/> <label
                        for="action">{l s='Action'}</label>
                <br/>
                <input type="radio" name="genre" value="Western" id="western"/>
                <label for="western">{l s='Western'}</label>
                <br/>
                <input type="radio" name="genre"
                       value="Thriller"
                       id="thriller"/> <label
                        for="thriller">{l s='Thriller'}</label>
                <br/>
                <input type="radio" name="genre" value="Fantastique / Science-Fiction" id="fantastic_sf"/> <label
                        for="fantastic_sf">{l s='Fantastique / Science-Fiction'}</label>
                <br/>
                <input type="radio" name="genre" value="Horreur / Epouvante" id="horror_ep"/>
                <label for="horror_ep">{l s='Horreur / Epouvante'}</label>

                <br/>
                <input type="radio" name="genre" value="Historique / Peplum" id="historic_peplum"/>
                <label for="historic_peplum">{l s='Historique / Peplum'}</label>

                <br/>
                <input type="radio" name="genre" value="Aventure / Cape et épée" id="adventure"/>
                <label for="adventure">{l s='Aventure / Cape et épée'}</label>

                <br/>
                <input type="radio" name="genre" value="Documentaire" id="documentaire"/>
                <label for="documentaire">{l s='Documentaire'}</label>

                <br/>
                <input type="radio" name="genre" value="Animation" id="animation"/>
                <label for="animation">{l s='Animation'}</label>
                <br/>

                <h5>{l s='Précisez-nous l\'année de sortie désirée ?'}</h5>

                <input type="radio" name="year" value="1920-1939"
                       id="twenties_thirties"/> <label
                        for="twenties_thirties">{l s='1920-1939'}</label>
                <br/>

                <input type="radio" name="year" value="1940-1959"
                       id="fourties_fifties"/> <label
                        for="fourties_fifties">{l s='1940-1959'}</label>
                <br/>

                <input type="radio" name="year" value="1960-1979"
                       id="sixties_seventies"/> <label
                        for="sixties_seventies">{l s='1960-1979'}</label>
                <br/>

                <input type="radio" name="year" value="Années 80"
                       id="eighties"/> <label
                        for="eighties">{l s='Années 80'}</label>
                <br/>

                <input type="radio" name="year" value="Années 90"
                       id="nineties"/> <label
                        for="nineties">{l s='Années 90'}</label>
                <br/>

                <input type="radio" name="year" value="Années 2000 à nos jours"
                       id="millenium"/> <label
                        for="millenium">{l s='Années 2000 à nos jours'}</label>
                <br/>

                <input type="radio" name="year" value="Pas de préférence"
                       id="no_preference"/> <label
                        for="no_preference">{l s='Pas de préférence'}</label>
                <br/>

                <h5>{l s='Précisez-nous la provenance souhaitée ?'}</h5>

                <input type="radio" name="origin" value="France"
                       id="france"/> <label
                        for="france">{l s='France'}</label>
                <br/>

                <input type="radio" name="origin" value="Hollywood"
                       id="hollywood"/> <label
                        for="hollywood">{l s='Hollywood'}</label>
                <br/>

                <input type="text" name="origin" placeholder="{l s'Autre'}"
                       id="autre"/> <label
                        for="autre">{l s='Autre'}</label>
                <br/>

                <h5>{l s='Précisez-nous ce que vous attendez de voir'}</h5>
                <small>{l s='Précision du genre, du style, du pays, un réalisateur ou un acteur préféré... (30 caractères min.)'}</small>
                <textarea name="description_attentes"></textarea>

                <br/>
                <h5>{l s='Avez-vous déjà regardé des films dans ce genre-là ?'}</h5>
                <small>{l s='Si oui, le(s)quel(s) et qu\'en avez-vous pensé ? (30 caractères min.)'}</small>
                <textarea name="description_genre"></textarea>

                <br/>
                <h5>{l s='Voulez-vous que l\'on vous soumette notre choix ?'}</h5>
                <input type="radio" name="soumission_choix"
                       value="Oui, je souhaite valider le choix" id="soumission_oui"/>
                <label for="soumission_oui">{l s='Oui, je souhaite valider le choix'}</label>

                <br/>
                <input type="radio" name="soumission_choix" value="Non, surprenez-moi !"
                       id="soumission_non"/>
                <label for="soumission_non">{l s='Non, surprenez-moi !'}</label>

                {*<br/>
                <h5>{l s='Allez-vous offrir ce Pot Pourri à quelqu\'un ?'}</h5>
                <input type="radio" name="cadeau" value="Oui, je souhaite valider le choix"
                       id="cadeau_oui"/>
                <label for="cadeau_oui">{l s='Oui'}</label>

                <br/>
                <input type="radio" name="cadeau" value="Non, surprenez-moi !" id="cadeau_non"/>
                <label for="cadeau_non">{l s='Non'}</label>*}
                <hr/>
            </div>
        </div>
    </div>
</div>