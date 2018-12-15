package tree is
    
    type T_Tree is private;
    type T_Bit is mod 2;

    procedure Initialize(Tree : out T_Tree);
    
    function Get_Character(Tree: in T_Tree) return Character with
	    Pre => not is_Empty(Tree);
     
    procedure Add_Occurence(Tree : in out T_Tree) with
	    Pre => not is_Empty(Tree);   
    
    function Get_Occurence(Tree : in T_Tree) return Integer;
    
    function Get_Bit(Tree : in T_Tree) return T_Bit;
    
    function Get_Children_Left(Tree : in T_Tree) return T_Tree with
	    Pre => Is_Node(Tree);
    
    function Get_Children_Right(Tree : in T_Tree) return T_Tree with
	    Pre => Is_Node(Tree);
    
    function Is_Empty(Tree : in T_Tree) return Boolean;

    function Is_Node(Tree : in T_Tree) return Boolean;

    function Create_Leaf(c : Character) return T_Tree;
    
    function Bind(Tree_Left : in out T_Tree; Tree_Right : in out T_Tree) return T_Tree with
	    Pre => not Is_Empty(Tree_Left) and not is_Empty(Tree_Right);
    
    procedure Clean_Up(Tree : in out T_Tree);

    
private

    type T_Leaf is record
	char : Character;
	occurrence : Integer;
	bit : T_Bit;
	children_left : T_Tree;
	children_right : T_Tree;
    end record;
    type T_Tree is access T_Leaf;

end tree;
