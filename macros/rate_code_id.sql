{% macro rate_code_id(RatecodeID) %}
    
    case {{ RatecodeID }}
        when 1 then 'Standard Rate'
        when 2 then 'JKF'
        when 3 then 'Newark'
        when 4 then 'Nassau or Westchester'
        when 5 then 'Negotiated Fare'
        when 6 then 'Group Ride'
    end

{% endmacro %}