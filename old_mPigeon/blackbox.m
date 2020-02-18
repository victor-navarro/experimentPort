function blackbox(varargin)

global gmpigeonPort;
p=gmpigeonPort;

try
        if strcmp(varargin(1),'feeder')
            if nargin==1
                IOPort('Write', p, uint8(254));
                IOPort('Write', p, uint8(3));
                WaitSecs(.25);
                IOPort('Write', p, uint8(254));
                IOPort('Write', p, uint8(2));
            else
                if strcmp(varargin(2),'on')
                    IOPort('Write', p, uint8(254));
                    IOPort('Write', p, uint8(3));
                    waitsecs(.25);
                    IOPort('Write', p, uint8(254));
                    IOPort('Write', p, uint8(2));                    
                end
            end
            
        end

        
        if (strcmp(varargin(1),'light')||strcmp(varargin(1),'lamp'))

            if nargin==1
                IOPort('Write', p, uint8(254));
                IOPort('Write', p, uint8(1));
            else
                if strcmp(varargin(2),'on')
                    IOPort('Write', p, uint8(254));
                    IOPort('Write', p, uint8(1));
                else
                    IOPort('Write', p, uint8(254));
                    IOPort('Write', p, uint8(0)); 
                end
            end
              
        end



        if strcmp(varargin(1),'dark')

                IOPort('Write', p, uint8(254));
                IOPort('Write', p, uint8(0));           
        end

catch
end


%Both on
%254 
%6
%3

