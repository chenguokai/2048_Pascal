program my2048;
uses crt;
 var map:array[1..4,1..4] of longint;
  i,g,h,j,k,l,loop1,loop2,loop3,loop4,time:longint;
  c:char;
  config:text;
  trail:text;
  win,lose:boolean;
  accept,wining,losing:longint;
 procedure readd;
  var i,h,j,k,l:longint;
   begin
    randomize;
    j:=0;
    repeat
     k:=random(4)+1;
     l:=random(4)+1;
     if map[k,l]=0 then
                     begin
                      map[k,l]:=2;
                      inc(j);
                     end;
    until j=1;
   end;
 procedure judge;
  begin
   for i:= 1 to 4 do
    for j:= 1 to 4 do
     begin
     if map[i,j]=2048 then
                        begin
                        win:=true;
                        end;
     end;
  end;
 procedure start;
  var s:string;
  begin
   write('input yes to proceed');
   readln(s);
   if s<>'yes' then
                 begin
                 writeln(config,accept);
                 writeln(config,wining);
                 writeln(config,losing);
                 close(config);
                 dec(time);
                 rewrite(trail);
                 write(trail,time);
                 halt;
                 end;
  end;
 procedure print;
  var i,j:longint;
   begin
    for i:= 1 to 4 do
     begin
      for j:= 1 to 4 do
       write(map[i,j]:4,' ');
      writeln;
     end;
   end;
 procedure setting;
  var i,j:longint;
   begin
    readln(config,accept);
    readln(config,wining);
    readln(config,losing);
   end;
 Begin
  assign(trail,'trying.txt');
  reset(trail);

  readln(trail,time);
  close(trail);
  if time<1 then
              begin
               write('Out of trail time!');
               readln;
              end;
  assign(config,'config.txt');
  reset(config);
  setting;
  close(config);
  rewrite(config);

  if accept=0 then
                start;
  randomize;
  repeat // init the map
  k:=random(4)+1;
  l:=random(4)+1;
  if map[k,l]=0 then
                  begin
                  map[k,l]:=2;
                  inc(j);
                  end;
  until j=2; // map init end
  repeat
  print;
  readln(c);
  case c of  // the case begin
  'a':begin
       for loop1:= 1 to 4 do
        for loop2:= 4 downto 2 do
         begin
          if (map[loop1,loop2-1]=0) then
                                      begin
                                       map[loop1,loop2-1]:=map[loop1,loop2];
                                       map[loop1,loop2]:=0;
                                      end;
          if map[loop1,loop2-1]=map[loop1,loop2] then
                                                   begin
                                                    map[loop1,loop2-1]:=map[loop1,loop2]*2;
                                                    map[loop1,loop2]:=0;
                                                    for loop3:= loop2 to 4 do
                                                     if map[loop1,loop3]<>0 then
                                                                              begin
                                                                               for loop4:= loop3 to 4 do
                                                                                map[loop1,loop4]:=map[loop1,loop4+loop3-loop2];
                                                                              end;
                                                   end;

         end;
      end;
  'd':begin
       for loop1:= 1 to 4 do
        for loop2:= 3 downto 1 do
         begin
          if (map[loop1,loop2+1]=0) then
                                      begin
                                       map[loop1,loop2+1]:=map[loop1,loop2];
                                       map[loop1,loop2]:=0;
                                      end;
          if map[loop1,loop2+1]=map[loop1,loop2] then
                                                   begin
                                                    map[loop1,loop2+1]:=map[loop1,loop2+1]*2;
                                                    map[loop1,loop2]:=0;
                                                   end;

         end;
      end;
  'w':begin
       for loop1:= 4 downto 2 do
        for loop2:= 1 to 4 do
         begin
          if (map[loop1-1,loop2]=0) then
                                      begin
                                       map[loop1-1,loop2]:=map[loop1,loop2];
                                       map[loop1,loop2]:=0;
                                      end;
          if map[loop1-1,loop2]=map[loop1,loop2] then
                                                   begin
                                                    map[loop1-1,loop2]:=map[loop1-1,loop2]*2;
                                                    map[loop1,loop2]:=0;
                                                   end;

         end;
      end;
  's':begin
       for loop1:= 1 to 3 do
        for loop2:= 1 to 4 do
         begin
          if (map[loop1+1,loop2]=0) then
                                      begin
                                       map[loop1+1,loop2]:=map[loop1,loop2];
                                       map[loop1,loop2]:=0;
                                      end;
          if map[loop1+1,loop2]=map[loop1,loop2] then
                                                   begin
                                                    map[loop1+1,loop2]:=map[loop1+1,loop2]*2;
                                                    map[loop1,loop2]:=0;
                                                   end;

         end;
      end;
  'e':begin
      writeln(config,accept);
      writeln(config,wining);
      writeln(config,losing+1);
      rewrite(trail);
      write(trail,time-1);
      close(trail);
      close(config);
      halt;
      end;
  end; //end the case
  readd;
  judge;
  ClrScr;
  until (win=true)or(lose=true);
  if win=true then inc(wining)
              else inc(losing);
  write(accept);
  write(wining);
  write(losing);
 End.
