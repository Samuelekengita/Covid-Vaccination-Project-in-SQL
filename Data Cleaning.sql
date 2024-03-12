SELECT *
FROM Nashvillehousing

SELECT Sales_Dates, CONVERT (Date, SaleDate)
FROM PortfolioProject..Nashvillehousing

UPDATE Nashvillehousing
SET SaleDate = CONVERT (Date, SaleDate)

ALTER TABLE Nashvillehousing
ADD Sales_Dates Date;

UPDATE Nashvillehousing
SET Sales_Dates =  CONVERT (Date, SaleDate)


SELECT a. PropertyAddress, a.ParcelID, b.PropertyAddress, b.ParcelID, ISNULL (a. PropertyAddress, b.PropertyAddress)
FROM PortfolioProject..Nashvillehousing a
JOIN PortfolioProject..Nashvillehousing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

UPDATE a
SET PropertyAddress = ISNULL (a. PropertyAddress, b.PropertyAddress)
FROM PortfolioProject..Nashvillehousing a
JOIN PortfolioProject..Nashvillehousing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

--BREAKING OUT ADDRESS INTO INDIVIDUAL COLUMNS 9ADDRESS, CITY, STATE)

SELECT PropertyAddress
FROM PortfolioProject.. Nashvillehousing


SELECT SUBSTRING (PropertyAddress, 1, CHARINDEX (',', PropertyAddress)-1) as Address,
 SUBSTRING (PropertyAddress, Charindex (',', PropertyAddress) +1, LEN(PropertyAddress)) as State
FROM PortfolioProject.dbo.Nashvillehousing

alter table PortfolioProject.. Nashvillehousing
Add PropertyAddressPlit nvarchar (255)

Update PortfolioProject.. Nashvillehousing
Set PropertyAddressPlit = SUBSTRING (PropertyAddress, 1, CHARINDEX (',', PropertyAddress)-1)

alter table PortfolioProject.. Nashvillehousing
Add PropertyAddressHouse nvarchar (255)

Update PortfolioProject.. Nashvillehousing
Set PropertyAddressHouse = SUBSTRING (PropertyAddress, Charindex (',', PropertyAddress) +1, LEN(PropertyAddress))


SELECT
PARSENAME (Replace(OwnerAddress, ',' , '.' ), 3),
PARSENAME (REPLACE(OwnerAddress, ',', '.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',','.'),1)
FROM PortfolioProject..Nashvillehousing

alter table PortfolioProject.. Nashvillehousing
Add OnwerAddress nvarchar (255)

Update PortfolioProject.. Nashvillehousing
Set OnwerAddress = PARSENAME (Replace(OwnerAddress, ',' , '.' ), 3)

Alter table PortfolioProject..Nashvillehousing
add Owner_Address_State Nvarchar (255)

Update PortfolioProject.. Nashvillehousing
SET Owner_Address_State = PARSENAME (REPLACE(OwnerAddress, ',', '.'), 2)

Alter table PortfolioProject..Nashvillehousing
add Owner_Address_City Nvarchar (255)

Update PortfolioProject.. Nashvillehousing
SET Owner_Address_City = PARSENAME (REPLACE(OwnerAddress, ',', '.'), 1)


--Change Y and N to Yes and No in "Sold as Vacant feild"

SELECT distinct (SoldAsVacant), count (SoldAsVacant)
FROM PortfolioProject..Nashvillehousing
group by SoldAsVacant
order by 2

select SoldAsVacant
,case
	when SoldAsVacant = 'Y' then 'Yes'
	when SoldAsVacant ='N' then 'No'
	else SoldAsVacant
end
FROM PortfolioProject..Nashvillehousing

update PortfolioProject..Nashvillehousing
set SoldAsVacant =  case
	when SoldAsVacant = 'Y' then 'Yes'
	when SoldAsVacant ='N' then 'No'
	else SoldAsVacant
end

--Delete Duplicate coloumns

alter table Nashvillehousing
drop column SaleDate, OwnerAddress, SaleDateConverted 

alter table Nashvillehousing
drop column Sales_Dates, Salesdate1, RealSaleDate, Saledate4

alter table Nashvillehousing
drop column SaleDateConverted

SELECT *
from PortfolioProject..Nashvillehousing