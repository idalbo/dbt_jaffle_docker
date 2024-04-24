# This is a Jaffle Shop test

```sql customers
select * from jaffle_shop.customers
```

```sql orders
select * from jaffle_shop.orders
```

```sql order_dates
select order_date from jaffle_shop.orders
```

```sql sales_by_week
select
    date_trunc('week', order_date) as week,
    sum(amount) as total_sales
from
    jaffle_shop.orders
where
    order_date between '${inputs.date_range.start}' and '${inputs.date_range.end}'
group by
    1
order by
    1
```

<DateRange
    name="date_range"
    data={order_dates}
    dates=order_date
    title="Select Date Range"
/>

<BarChart
    data={sales_by_week}
    title="Weekly Sales"
    x="week"
    y="total_sales"
/>

```sql top_customers
select * from ${customers} limit ${inputs.top_n_customer_input}
```

```sql max_customers
select count(*) as num_customers from ${customers}
```


<TextInput
    name=top_n_customer_input
    title="Select the number of customers to display"
    defaultValue=10
/>

<DataTable
    data={top_customers}
    title="Top Customers"
/>