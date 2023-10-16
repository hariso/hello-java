package com.meroxa;

import com.meroxa.turbine.Turbine;
import com.meroxa.turbine.TurbineApp;
import com.meroxa.turbine.TurbineRecord;
import jakarta.enterprise.context.ApplicationScoped;

import java.util.List;

import static java.time.LocalDateTime.now;

@ApplicationScoped
public class Main implements TurbineApp {

    @Override
    public void setup(Turbine turbine) {
        turbine
            .resource("source_name")
            .read("collection_name", null)
            .process(this::process)
            .writeTo(turbine.resource("destination_name"), "collection_enriched", null);
    }

    private List<TurbineRecord> process(List<TurbineRecord> records) {
        return records.stream()
            .filter(r -> r.jsonGet("$.payload.after.id").equals(9582724))
            .map(r -> {
                var copy = r.copy();
                copy.setPayload("customer emails is" + copy.jsonGet("$.payload.after.customer_email"));

                return copy;
            })
            .toList();
    }
}
