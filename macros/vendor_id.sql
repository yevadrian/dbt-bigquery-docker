{% macro vendor_id(VendorID) %}
    
    case {{ VendorID }}
        when 1 then 'Creative Mobile Technologies, LLC'
        when 2 then 'VeriFone Inc.'
    end

{% endmacro %}