from abc import ABC, abstractmethod
from typing import Any
from uuid import UUID


class BaseStorage(ABC):
    @abstractmethod
    async def get_data_list(self, page_number: int, page_size: int):
        pass

    @abstractmethod
    async def get_data_by_id(self, id: UUID):
        pass


class BaseCache(ABC):
    @abstractmethod
    async def get_from_cache(self, url: str):
        pass

    @abstractmethod
    async def put_to_cache(self, url: str, data: Any):
        pass
