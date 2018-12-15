with Ada.Sequential_IO;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Directories; use Ada.Directories;

package body writer is

    package Bin_IO is
	    new Ada.Sequential_IO(T_Byte);
    use Bin_IO;


    file_compressed : Bin_IO.File_Type;

    procedure Create_Compressed_File is
    begin
	create(file_compressed, Out_File, "./" & file_name & ".hf");
	Clean_Buffer;
	text_size := T_Size_Text(File_Size(Size("./" & file_name)));
    end;

    procedure Write_Text_Size is
	buffer_text_size : T_Byte;
	long_byte : T_Size_Text;
    begin
	for i in reverse 0..3 loop
	    long_byte := (text_size / (2**(8*i))) * 2**(8*i);
	    text_size := text_size - long_byte;
	    buffer_text_size := T_Byte(long_byte/(2**(8*i)));
	    Bin_IO.Write(file_compressed, buffer_text_size);
	end loop;
    end;

    procedure Write_Bit(i : in Integer) is
	code : T_Code;
    begin
	code.length := 1;
	code.byte := T_Byte(i);
	Write_Byte(code);
    end;


    procedure Write_Integer(i : in Integer) is
    begin
	Bin_IO.Write(file_compressed, T_Byte(i));
    end;


    procedure Write_Byte(code : in T_Code) is
	rest : T_Code;
    begin

	if buffer.length + code.length = 8 then

	    Update_Buffer(code);
	    Write_Buffer;
	    Clean_Buffer;

	elsif buffer.length + code.length < 8 then

	    Update_Buffer(code);

	elsif buffer.length + code.length > 8 then

	    buffer.byte := buffer.byte * 2**(8 - code.length);
	    buffer.byte := buffer.byte + T_Byte(Integer(code.byte/(2**(8 - code.length + 1))));
	    rest.length := code.length - (8 - buffer.length);
	    Write_Buffer;
	    Clean_Buffer;
	    rest.byte := code.byte - T_Byte(Integer((code.byte/(2**(8 - code.length + 1)))*(2**(8 - code.length + 1))));
	    buffer.byte := rest.byte;
	    buffer.length := rest.length;

	end if;
    end;


    procedure Force_Write_Buffer is
    begin
	if buffer.length /= 0 then
	    buffer.byte := buffer.byte * 2**(8 - buffer.length);
	    Write_Buffer;
	    Clean_Buffer;
	end if;
    end;



    procedure Close_Compressed_File is
    begin
	close(file_compressed);
    end;


    procedure Update_Buffer(code : in T_Code) is
    begin
	buffer.byte := buffer.byte * 2**code.length;
	buffer.byte := buffer.byte + code.byte;
	buffer.length := buffer.length + code.length;
    end;


    procedure Write_Buffer is
    begin
	Bin_IO.write(file_compressed, buffer.byte);
    end;


    procedure Clean_Buffer is
    begin
	buffer.byte := T_Byte(0);
	buffer.length := 0;
    end;






end writer;
