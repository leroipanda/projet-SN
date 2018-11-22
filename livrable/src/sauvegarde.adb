  procedure Construire_Etape_Arbre(liste : in out liste_caractere.T_Liste ; Larbre : in out liste_arbre.T_Liste)
   is
      charactere1 : T_charactere;
      charactere2 : T_charactere;
      nv_charactere : T_charactere;
      procedure comparaison(element1 : in liste_arbre.T_Type;element2 : in liste_arbre.T_Type) is
      begin
         if liste_caractere.Renvoie_Element(element1).frequence >  liste_caractere.Renvoie_Element(element2).frequence then
            return True;
         else
            return False;
         end if;


      end comparaison;



      procedure construction is new arbre_element.Insersion_Arbre_Ordonne(ccomparaison );



   begin
      charactere1 := liste_caractere.Element_Debut(liste);
      liste_caractere.Supprimer_premier_Element(liste );
      charactere2 := liste_caractere.Element_Debut(liste);
      liste_caractere.Supprimer_premier_Element(liste );
      nv_charactere := ('"', charactere1.frequence + charactere2.frequence);
      liste_caractere.Ajouter_Element(liste,nv_charactere);



   end Construire_Etape_Arbre;
