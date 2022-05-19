#!/usr/bin/perl

my %opcode = (add   => '000000',
	      addi  => '001000',
	      addiu => '001001',
	      addu  => '000000',
	      and   => '000000',
	      andi  => '001100',
	      beq   => '000100',
	      bne   => '000101',
	      j     => '000010',
	      jal   => '000011',
	      jr    => '000000',
	      lbu   => '100100',
	      lhu   => '100101',
	      lui   => '001111',
	      ll    => '110000',
	      lw    => '100011',
	      or    => '000000',
	      ori   => '001101',
	      slt   => '000000',
	      slti  => '001010',
	      sll   => '000000',
	      srl   => '000000',
	      sw    => '101011',
	      sub   => '000000');

my %reg = ('$zero' => '00000',
	   '$at'   => '00001',
	   '$v0'   => '00010',
	   '$v1'   => '00011',
	   '$a0'   => '00100',
	   '$a1'   => '00101',
	   '$a2'   => '00110',
	   '$a3'   => '00111',
	   '$t0'   => '01000',
	   '$t1'   => '01001',
	   '$t2'   => '01010',
	   '$t3'   => '01011',
	   '$t4'   => '01100',
	   '$t5'   => '01101',
	   '$t6'   => '01110',
	   '$t7'   => '01111',
	   '$s0'   => '10000',
	   '$s1'   => '10001',
	   '$s2'   => '10010',
	   '$s3'   => '10011',
	   '$s4'   => '10100',
	   '$s5'   => '10101',
	   '$s6'   => '10110',
	   '$s7'   => '10111',
	   '$t8'   => '11000',
	   '$t9'   => '11001',
	   '$k0'   => '11010',
	   '$k1'   => '11011',
	   '$gp'   => '11100',
	   '$sp'   => '11101',
	   '$fp'   => '11110',
	   '$ra'   => '11111',
	   '$0' => '00000',
	   '$1' => '00001',
	   '$2' => '00010',
	   '$3' => '00011',
	   '$4' => '00100',
	   '$5' => '00101',
	   '$6' => '00110',
	   '$7' => '00111',
	   '$8' => '01000',
	   '$9' => '01001',
	   '$10' => '01010',
	   '$11' => '01011',
	   '$12' => '01100',
	   '$13' => '01101',
	   '$14' => '01110',
	   '$15' => '01111',
	   '$16' => '10000',
	   '$17' => '10001',
	   '$18' => '10010',
	   '$19' => '10011',
	   '$20' => '10100',
	   '$21' => '10101',
	   '$22' => '10110',
	   '$23' => '10111',
	   '$24' => '11000',
	   '$25' => '11001',
	   '$26' => '11010',
	   '$27' => '11011',
	   '$28' => '11100',
	   '$29' => '11101',
	   '$30' => '11110',
	   '$31' => '11111');

my %format = (add   => 'R',
	      addi  => 'I',
	      addiu => 'I',
	      addu  => 'R',
	      and   => 'R',
	      andi  => 'I',
	      beq   => 'IM1',
	      bne   => 'IM1',
	      j     => 'J',
	      jal   => 'J',
	      jr    => 'RJ',
	      lbu   => 'IM2',
	      lhu   => 'IM2',
	      lui   => 'IM3',
	      ll    => 'IM2',
	      lw    => 'IM2',
	      or    => 'R',
	      ori   => 'I',
	      slt   => 'R',
	      slti  => 'I',
	      sll   => 'R',
	      srl   => 'R',
	      sw    => 'IM2',
	      sub   => 'R');

my %function = (add   => '100000',
	        addi  => '001000',
		addiu => '001001',
		addu  => '100001',
		and   => '100100',
		andi  => '001100',
		beq   => '000100',
		bne   => '000101',
		j     => '000010',
		jal   => '000011',
		jr    => '001000',
		lbu   => '100100',
		lhu   => '100101',
		lui   => '001111',
		ll    => '110000',
		lw    => '100011',
		or    => '100101',
		ori   => '001101',
		slt   => '101010',
		slti  => '001010',
	        sll   => '000000',
	        srl   => '000010',
	        sw    => '101011',
                sub   => '100010');

my %ascii = (Y  =>  '01011001',
	     o  =>  '01101111',
	     u  =>  '01110101',
	     a  =>  '01100001',
	     r  =>  '01110010',
	     e  =>  '01100101',
	     m  =>  '01101101',
	     i  =>  '01101001',
	     n  =>  '01101110',
	     I  =>  '01001001',
	     y  =>  '01111001');

my $fileasm;
my $fh;
my $filetxt = 'input.txt';

if (open($fileasm, '<', $ARGV[0])) 
{
        open ($fh, '>', $filetxt);
        while (my $line = <$fileasm>) 
	{
        	chomp $line;
                @string = split(/#/, $line);
                $string[0] =~ s/^\s+|\s+$//;
                my ($var1, $var2) = split(/ /, $string[0], 2);
		my ($m, $n) = split(/ /, $var2, 2);
                $var1 =~ s/\s//gs;
		$var2 =~ s/\s//gs;
		$n =~ s/\s//gs;
		if ((length($var1) == 5) and (length($n) == 10))
		{
			$var1 = join(" ", $var1, $m);
			$var2 = $n;
		}
		@string1 = split(/,/, $var2);
                $out = join(" ", @string1);
                $oput = join(" ", $var1, $out);
		printf $fh "$oput\n";
        }
}
close($fileasm);
close($fh);


open $fileasm, $ARGV[0];
seek $fileasm, 0, 0;
open $data_output, ">DATAsegment.txt";
foreach $line (<$fileasm>)
{
	if ($line =~ /.asciiz/){
		my @array = split (/[""]/, $line);
		my @temp = unpack("C*", $array[1]);
		push(@data_array, @temp);
		push(@data_array, $zero);
	}
	elsif ($line =~ /.ascii/){ 
		my @array = split (/[""]/, $line);
		my @temp = unpack("C*", $array[1]);
		push(@data_array, @temp);
	}
	elsif ($line =~ /.byte/){ 
		my @array = split(/ /, $line);
		for (my $i = 2; $i < scalar @array; $i++){
			my $temp = $array[$i];
			push(@data_array, $temp);
		}
	}
	elsif ($line =~ /.word/){
		while(scalar @data_array % 4 != 0){
			push(@data_array, $zero);
		}
		my @array = split(/ /, $line);
		for (my $i = 2; $ i < scalar @array; $i++){
			push(@data_array, @array[$i]);
			push(@data_array, $zero);
			push(@data_array, $zero);
			push(@data_array, $zero);
		}
	}
	elsif ($line =~ /.text/){
		for (my $i = 0; $i < scalar @data_array; $i++){
			$data_array[$i] = sprintf('%.2x', $data_array[$i]);
		}
		write_data_out();
	}

	close ($fileasm);
}
sub write_data_out
{
	my $index = 0;
	
	my $count = 1;
	while($index != scalar(@data_array)){
		my $temp = join("", $data_array[$index + 3], $data_array[$index + 2],
			$data_array[$index + 1], $data_array[$index]);
		$temp = sprintf('%08s', $temp);
		$temp = substr($temp, -8);
		$index += 4;
		$count += 1;
		print $data_output $temp;
		print $data_output "\n";
	}
	while($count != 1025){
		print $data_output "00000000\n";
		$count += 1;
	}
	print $data_output "\n";
	close $data_output;
}

my $fh1, $fh2;
my $op, $opc, $rs, $rt, $rd, $shamt, $func;
my $dem = 0;

if (open($fh1, '<', $filetxt))
{
	open($fh2, '>TEXTsegment.txt');
	while(my $line = <$fh1>)
	{
		chomp $line;
		
		if ((substr($line, -2) ne ': ') and (length($line) > 1))
			{$dem += 1;}
		my ($vlue1, $vlue2, $vlue3, $vlue4, $vlue5) = split(/ /, $line, 5);
		if (length($opcode{$vlue1}) != 6 and length($opcode{$vlue2}) == 6)
		{
			$vlue1 = $vlue2;
			$vlue2 = $vlue3;
			$vlue3 = $vlue4;
			$vlue4 = $vlue5;
		}
		$op = $format{$vlue1};
		$opc = $opcode{$vlue1};
		if ($op eq 'R')
		{
			$rs = $reg{$vlue3};
			$rt = $reg{$vlue4};
			$rd = $reg{$vlue2};
			$shamt = '00000';
			$func = $function{$vlue1};
			my $result = $opc.$rs.$rt.$rd.$shamt.$func;
			my $hexnum = oct("0b".$result);
			#printf $fh2 '%#.8x', $hexnum;
			printf $fh2 "$result\n";
			#print $fh2 "\n";
		}
	        elsif ($op eq 'RJ')
		{
			$rs = $reg{$vlue2};
			my $var = '000000000000000';
			$func = $function{$vlue1};
			my $result = $opc.$rs.$var.$func;
                        my $hexnum = oct("0b".$result);
			#printf $fh2 '%#.8x', $hexnum;
			#print $fh2 "\n";
			printf $fh2 "$result\n";
		}	
		elsif ($op eq 'I')
		{
			$rs = $reg{$vlue3};
			$rt = $reg{$vlue2};
			my $bin = sprintf ("%.16b", $vlue4);
			$bin = substr($bin, -16);
			my $result = $opc.$rs.$rt.$bin;
		        my $hexnum = oct("0b".$result);
			#printf $fh2 '%#.8x', $hexnum;
			#print $fh2 "\n";
			printf $fh2 "$result\n";
		}
		elsif ($op eq 'IM1')
		{
			my $dem1 = 0;
			my $dem2;
			open($fh, '<', $filetxt);
		    	while($line1 = <$fh>)
			{
				chomp $line1;
				my ($a, $b) = split(/:/, $line1, 2);
				
				if ($a eq $vlue4)
		                {
          	                      $dem2 = $dem1;
	                        }
				
				if ((substr($line1, -2) ne ': ') and (length($line1) > 1))
				{
					$dem1 += 1;
				}
			}	
			my $count = $dem2 - $dem;
	
			close ($fh);

			my $bin = sprintf ("%.16b", $count);
			$bin = substr($bin, -16);
			$rs = $reg{$vlue2};
			$rt = $reg{$vlue3};
			my $result = $opc.$rs.$rt.$bin;
	                my $hexnum = oct("0b".$result);
			#printf $fh2 '%#.8x', $hexnum;
			#print $fh2 "\n";
			printf $fh2 "$result\n";
		}
		elsif ($op eq 'IM2')
		{
			my ($var1, $var2) = split(/[()]/, $vlue3);
			$rs = $reg{$var2};
			$rt = $reg{$vlue2};
			my $bin = sprintf ("%.16b", $var1);
			$bin = substr($bin, -16);
			my $result = $opc.$rs.$rt.$bin; 
 			my $hexnum = oct("0b".$result);
			#printf $fh2 '%#.8x', $hexnum;
			#print $fh2 "\n";
			printf $fh2 "$result\n";
		}
		elsif ($op eq 'IM3')
		{
			my $bin = sprintf ("%.16b", $vlue3);
			my $var = '00000';
			$rt = $reg{$vlue2};
			my $result = $opc.$var.$rt.$bin;
			my $hexnum = oct("0b".$result);
			#printf $fh2 '%#.8x', $hexnum;
			#print $fh2 "\n";
			printf $fh2 "$result\n";
		}
		elsif ($op eq 'J')
		{
			my $count = 4194304; #0x00400000
			open($fh, '<', $filetxt);	
			while($line1 = <$fh>)
			{
				chomp $line1;
				my ($a1, $a2) = split(/:/, $line1);
				my ($b1, $b2) = split(/ /, $line1);
				if ($a1 eq $vlue2)
				{
					$vlue2 = $count;
				}
				if ((substr($line1, -1) ne ':') and (length($line1) != 0) and length($opcode{$b1}) == 6)
				{
					$count += 4;
				}
			}
			close ($fh);
			
			my $bin = sprintf ("%.26b", $vlue2);
			$bin = substr($bin, -26);
			my $var = substr ($bin, 24, 2); # Lay 2 bit cuoi cua chuoi $bin
			$bin = substr ($bin, 0, 24);
			my $result = $opc.$var.$bin;
                        my $hexnum = oct("0b".$result);
			#printf $fh2 '%#.8x', $hexnum;
			#print $fh2 "\n";
			printf $fh2 "$result\n";
		}
	
	}
}

close($fh1);
close($fh2);
