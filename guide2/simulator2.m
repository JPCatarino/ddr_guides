function [b_hd b_4k] = simulator2(lambda, p, n, S, W, R, fname)
    % Parameters
    % lambda - movies request rate (req/hour)
    % p - percentage of request for 4k movies (%)
    % n - number of servers
    % S - interface capacity of each server (mbps)
    % W - resourse reservation for 4K movies (mbps)
    % R - number of movie requests to stop simulation
    % fname - file name with the duration (in minutes) of the items
    
    invlambda=60/lambda;     %average time between requests (in minutes)
    invmiu= load(fname);     %duration (in minutes) of each movie
    Nmovies= length(invmiu); %number of movies
    C = n * S;               %Internet Connection Capability
    M_4k = 25;               %throughoutput of a 4k movie
    M_hd = 5;                %throughoutput of a hd movie
    
    %Events definition:
    ARRIVAL = 0;                %movie request
    DEPARTURE_HD = zeros(1, n); %termination of a HD movie transmission
    DEPARTURE_4K = zeros(1, n); %termination of a 4k movie transmission
    %State variables initialization:
    STATE = zeros(1, n);
    STATE_HD = 0;
    %Statistical counters initialization:
    NARRIVALS = 0;
    REQUESTS_HD = 0;
    REQUESTS_4K = 0;
    BLOCKED_HD = 0;
    BLOCKED_4K = 0;
    %Simulation Clock and initial List of Events:
    Clock= 0;
    EventList= [ARRIVAL exprnd(invlambda)];
    
    while REQUESTS_HD+REQUEST_4K < R
        event= EventList(1,1);
        Previous_Clock= Clock;
        Clock= EventList(1,2);
        EventList(1,:)= [];
        
        if event == ARRIVAL
            EventList= [EventList; ARRIVAL Clock+exprnd(invlambda)];
            NARRIVALS= NARRIVALS+1;
            % Find which request was made
            % Choose the right server according 
            % to the load rules.
            % Se 
            if p <= rand()
                least_loaded_c, least_loaded_i = min(STATE)
                if S - least_loaded_c >= 25
                    STATE(least_loaded_i) = least_loaded_c + M_4k;
                    EventList= [EventList; DEPARTURE Clock+invmiu(randi(Nmovies))];
                else
                    BLOCKED_4K = BLOCKED_4K + 1:
                end
            else
            end  
        else
            STATE= STATE-M;
        end
        EventList= sortrows(EventList,2);
    end
    b_hd= 100*BLOCKED_HD/REQUESTS_HD;    % HD blocking probability in %
    b_4k = 100*BLOCKED_4K/REQUESTS_4K;   % 4K blocking probability in %
end