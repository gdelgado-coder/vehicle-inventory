async function loadVehicles() {
    const brand = document.getElementById("filterBrand").value;
    const model = document.getElementById("filterModel").value;
    const year = document.getElementById("filterYear").value;

    let url = `/api/vehicles?brand=${brand}&model=${model}&year=${year}`;

    const res = await fetch(url);
    const data = await res.json();

    const tbody = document.querySelector("#vehiclesTable tbody");
    tbody.innerHTML = "";

    data.forEach(v => {
        const tr = document.createElement("tr");

        tr.innerHTML = `
            <td>${v.id}</td>
            <td>${v.brand?.name}</td>
            <td>${v.model?.name}</td>
            <td>${v.year}</td>
            <td>${v.color}</td>
            <td>${v.price}</td>
            <td>${v.mileage}</td>
            <td>${v.status}</td>
        `;

        tbody.appendChild(tr);
    });
}

loadVehicles();
