package tree is
    
    type T_Tree is private;
    type T_Bit is mod 2;

    -- Initialiser un arbre
    --
    -- Paramètre:
    --		tree: l'arbre à initialiser
    --
    -- Assure: l'arbre est vide pointeur = null 
    procedure Initialize(Tree : out T_Tree);
    post => is_Empty(Tree);
    
     -- renvoie le caractere de la la feuille pointée par l'arbre 
    --
    -- Paramètre:
    --		tree: l'arbre dont on souhaite connaitre le caractere de la la feuille pointée
    --retourne : 
    --          charactere
     --necessite : 
     --          l'arbre ne soit pas vide et le caractere soit definie 
    function Get_Character(Tree: in T_Tree) return Character with
	    Pre => not is_Empty(Tree);
     -- incremente l'occurence de la feuille pointée par l'arbre  
    --
    -- Paramètre:
    --		tree: l'arbre dont on souhaite incremente la feuille pointée
    --
     --necessite : 
     --          l'arbre ne soit pas vide 
     --assure :
     --          occurence apres apelle = ocurence avant appelle +1  
    procedure Add_Occurence(Tree : in out T_Tree) with
            Pre => not is_Empty(Tree);
            post => Get_occurence(Tree) = Get_occurence(Tree)'old +1;
    -- renvoie l'occurence de la la feuille pointée par l'arbre 
    --
    -- Paramètre:
    --		tree: l'arbre dont on souhaite connaitre l'occurence de la la feuille pointée
    -- retourne : 
    --           integer
     --necessite : 
     --          l'arbre ne soit pas vide 
     --Assure :
     --          entier renvoyer >= 0 
     
    function Get_Occurence(Tree : in T_Tree) return Integer;
    Pre => not is_Empty(Tree); 
    post => Get_Occurence'Result >= 1 ;
    
    -- renvoie le byte de la la feuille pointée par l'arbre 
    --
    -- Paramètre:
    --		tree: l'arbre dont on souhaite connaitre le byte de la la feuille pointée
    --retourne : 
    --          T_Bit
     --necessite : 
     --          l'arbre ne soit pas vide 
     
    function Get_Bit(Tree : in T_Tree) return T_Bit;
    Pre => not is_Empty(Tree);
    
    -- renvoie le pointeur de l'enfant de gauche  de la la feuille pointée par l'arbre 
    --
    -- Paramètre:
    --		tree: l'arbre dont on souhaite connaitre l'enfant de gauche de la la feuille pointée
    --retourne : 
    --          T_Tree
     --necessite : 
     --          l'arbre soit un noeud donc qu'il est un enfant à droite et à gauche  (gauche uniquement suffit)
    function Get_Children_Left(Tree : in T_Tree) return T_Tree with
	    Pre => Is_Node(Tree);
    -- renvoie le pointeur de l'enfant de droite  de la la feuille pointée par l'arbre 
    --
    -- Paramètre:
    --		tree: l'arbre dont on souhaite connaitre l'enfant de droite de la la feuille pointée
    --retourne : 
    --          T_Tree
     --necessite : 
     --          l'arbre soit un noeud donc qu'il est un enfant à droite et à gauche (droite uniquement suffit)
    function Get_Children_Right(Tree : in T_Tree) return T_Tree with
            Pre => Is_Node(Tree);
    -- indique si l'arbre est vide 
    --
    -- Paramètre:
    --		tree: l'arbre dont on souhaite savoir si il est vide 
    --retourn : 
    --        boulean 
    

    function Is_Empty(Tree : in T_Tree) return Boolean;
    -- indique si l'arbre est un noeud 
    --
    -- Paramètre:
    --		tree: l'arbre dont on souhaite savoir si il est un noeud
    --retourn : 
    --        boulean 
    
    

    function Is_Node(Tree : in T_Tree) return Boolean;
       -- renvoie un arbre dont char vaut c  
    --
    -- Paramètre:
    --               c  : charactere la valeur de charactere souhaité
    --retourne : 
    --          T_Tree
    --assure :
     --         arbre renvoyé pas vide et que le caractere de l'arbre est bien c 
    

    function Create_Leaf(c : Character) return T_Tree;
    post => not Is_Empty(Create_Leaf'Result) and Get_Character(Create_Leaf'Result) = c ;
    
     --lie de arbre   
    --
    -- Paramètre:
     --		tree_left : l'arbre que l'on souhaite ajouter à gauche
     --		tree_right : l'arbre que l'on souhaite ajouter à droite
    --           
    --retourne : 
    --          T_Tree
    --assure :
     --         l'arbre droit et bien  l'enfant droit de la feuille de l'arbre renvoyée
     --          l'arbre gauche et bien  l'enfant gauche de la feuille de l'arbre renvoyée
    function Bind(Tree_Left : in out T_Tree; Tree_Right : in out T_Tree) return T_Tree with
	    Pre => not Is_Empty(Tree_Left) and not is_Empty(Tree_Right);
    --supprime proprement l'arbre    
    --
    -- Paramètre:
    --		tree : l'arbre à supprimer 
    --assure : 
     -- 	l'arbre est vide 
    procedure Clean_Up(Tree : in out T_Tree);
    post => Is_Empty(Tree );
    
private

    type T_Leaf is record
	char : Character;
	occurrence : Integer;
	byte : T_Bit;
	children_left : T_Tree;
	children_right : T_Tree;
    end record;
    type T_Tree is access T_Leaf;

end tree;
